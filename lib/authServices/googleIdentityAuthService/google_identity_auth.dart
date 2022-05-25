// import 'package:google_sign_in/google_sign_in.dart';

// Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         final UserCredential authResult =
//             await _auth.signInWithCredential(credential);
//         final User? user = authResult.user;

//         if (user != null) _redirectUser();
//       }
//     } catch (except) {
//       // ignore: avoid_print
//       print(except);
//     }
//   }