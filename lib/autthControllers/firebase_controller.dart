import 'dart:convert';

import 'package:firebase_dart/firebase_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_new/authServices/firebaseAuthService/configurations.dart';
import 'package:shelf_new/authServices/firebaseAuthService/firebase_auth.dart';
import 'package:shelf_new/databaseService/configurations.dart';
import 'package:shelf_new/databaseService/postgresql_database.dart';

class UserController {
  Future<FirebaseApp> initApp() async {
    late FirebaseApp app;

    try {
      app = Firebase.app();
    } catch (e) {
      app = await Firebase.initializeApp(
          options: FirebaseOptions.fromMap(Configurations.firebaseConfig));
    }

    return app;
  }

  // User registration route code
  Future<Response> register(Request request) async {
    var payloadData = await request.readAsString();
    if (payloadData.isEmpty) {
      return Response.notFound(
          jsonEncode({'success': false, 'error': 'No data found'}),
          headers: {'Content-Type': 'application/json'});
    }

    final payload = jsonDecode(payloadData);
    String? username = payload['username'];
    String? password = payload['password'];

    if (username == null || password == null) {
      return Response.notFound(
          json.encode({'error': 'Missing username or password'}),
          headers: {'content-type': 'application/json'});
    } else if (username.contains(' ')) {
      return Response.forbidden(
          json.encode({'error': 'Username cannot contain spaces'}),
          headers: {'content-type': 'application/json'});
    }

    final app = await initApp();
    final auth = FirebaseAuth.instanceFor(app: app);

    var response = await registerUser(
      username: username,
      password: password,
      auth: auth,
    );

    if (response[0] == 0) {
      return Response.notFound(response[1],
          headers: {'content-type': 'application/json'});
    } else {
      await DBConfig().dbConnection.open();
      print('Connected to Database!');
      createDbTable;
      await DBConfig().dbConnection.transaction((ctx) async {
        final dataStr = response[1].readAsString();
        final userData = jsonDecode(dataStr);
        final userDataStream = Stream.fromIterable(userData);

        await for (var row in userDataStream) {
          await ctx.query('''
            INSERT INTO users (id, email, message)
            VALUES (@uid, @username, @email, @message)
          ''', substitutionValues: {
            'id': row['uid'],
            'email': row['username'],
            'message': row['message'],
          });
        }
      });
      await DBConfig().dbConnection.close();
      return Response.ok(response[1],
          headers: {'content-type': 'application/json'});
    }
  }

  // login user routes code
  Future<Response> login(Request request) async {
    var projectData = await request.readAsString();
    if (projectData.isEmpty) {
      return Response.notFound(
          jsonEncode({'success': false, 'error': 'No data found'}),
          headers: {'Content-Type': 'application/json'});
    }
    final payload = json.decode(projectData);
    String? username = payload['username'];
    String? password = payload['password'];

    if (username == null || password == null) {
      return Response.notFound(
          json.encode({'error': 'Missing username or password'}),
          headers: {'content-type': 'application/json'});
    } else if (username.contains(' ')) {
      return Response.forbidden(
          json.encode({'error': 'Username cannot contain spaces'}),
          headers: {'content-type': 'application/json'});
    }

    final app = await initApp();
    final auth = FirebaseAuth.instanceFor(app: app);

    var response =
        await loginUser(username: username, password: password, auth: auth);

    if (response[0] == 0) {
      return Response.notFound(response[1],
          headers: {'content-type': 'application/json'});
    } else {
      return Response.ok(response[1],
          headers: {'content-type': 'application/json'});
    }
  }

  Future<Response> googlelogin(Request request) async {
    final app = await initApp();
    final auth = FirebaseAuth.instanceFor(app: app);

    await signInWithGoogle(auth);

    return Response.ok('User Logged In',
        headers: {'content-type': 'application/json'});
  }

  Future<Response> githublogin(Request request) async {
    final app = await initApp();
    final auth = FirebaseAuth.instanceFor(app: app);

    await signInWithGitHub(auth);

    return Response.ok('User Logged In',
        headers: {'content-type': 'application/json'});
  }

  // log out user route
  Future<Response> logout(Request request) async {
    final app = await initApp();
    final auth = FirebaseAuth.instanceFor(app: app);

    await logOutUser(auth);

    return Response.ok('User Logged Out',
        headers: {'content-type': 'application/json'});
  }
}
