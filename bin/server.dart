import 'dart:io';
// import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
// import 'package:shelf_new/databaseService/database_service.dart';
import 'package:shelf_new/routes/app_routes.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:firebase_dart/firebase_dart.dart';

Response _rootHandler(Request req) {
  return Response.ok('Hello, Welcome to Shelf Middleware\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Initialising dart firebase application
  FirebaseDart.setup();

  final router = Router();
  router.mount('/v1', AppRoutes().router);

  router.get('/', _rootHandler);

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  // await operation();
}
