import 'dart:convert';

import 'package:firebase_dart/firebase_dart.dart';

// Register user code
Future<List> registerUser({
  String? username,
  String? email,
  String? password,
  FirebaseAuth? auth,
}) async {
  try {
    var userCredential = await auth!.createUserWithEmailAndPassword(
      email: '$username@aortem.io'.toLowerCase(),
      password: password!,
    );

    return [
      1,
      json.encode({
        'username': username,
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
        'message': 'User created'
      })
    ];
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case 'weak-password':
        return [
          0,
          json.encode({'error': e.message})
        ];

      case 'internal-error':
        return [
          0,
          json.encode({'error': e.message})
        ];

      default:
        return [
          0,
          json.encode({'error': e.message})
        ];
    }
  }
}

// Login user code
Future loginUser({
  String? username,
  String? password,
  FirebaseAuth? auth,
}) async {
  try {
    var userCredential = await auth!.signInWithEmailAndPassword(
      email: '$username@aortem.io'.toLowerCase(),
      password: password!,
    );

    return [
      1,
      json.encode({
        'username': username,
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'message': 'User logged in'
      })
    ];
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case 'wrong-password':
        return [
          0,
          json.encode({'error': e.message})
        ];

      case 'user-not-found':
        return [
          0,
          json.encode({'error': e.message})
        ];

      case 'internal-error':
        return [
          0,
          json.encode({'error': e.message})
        ];

      default:
        return [
          0,
          json.encode({'error': e.message})
        ];
    }
  }
}

// Log in user with google account code
Future<UserCredential?> signInWithGoogle(FirebaseAuth? auth) async {
  try {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // final UserCredential authResult = await auth!.signInWithCredential(googleProvider)
    // final User? user = authResult.user;

    // return user;

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

// Log in with github account code
Future<UserCredential?> signInWithGitHub(FirebaseAuth? auth) async {
  try {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);

    // UserCredential authResult =
    //     await FirebaseAuth.instance.signInWithPopup(githubProvider);

    // final User? user = authResult.user;

    // return user;

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(githubProvider);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

// login with microsoft account code
// Future<UserCredential> signInWithMicrosoft(FirebaseAuth? auth) async {
//   // Create a new provider

// }

// Log out code
Future logOutUser(FirebaseAuth? auth) async {
  try {
    return auth!.signOut;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
