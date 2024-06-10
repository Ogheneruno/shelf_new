import 'package:google_sign_in/google_sign_in.dart';

// sign in with google identity

Future signInWithGoogle(GoogleSignInAccount user) async {
  try {
    await GoogleSignIn().signIn();
  } catch (e) {
    print(e.toString());
  }
}

// Sign out with google identity
Future<void> signOutWithGoogle() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
}

  // try {
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await GoogleSignIn().signIn();
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     final UserCredential authResult =
  //         await _auth.signInWithCredential(credential);
  //     final User? user = authResult.user;

  //     if (user != null) _redirectUser();
  //   }
  // } catch (except) {
  //   // ignore: avoid_print
  //   print(except);
  // }
