import 'package:google_sign_in/google_sign_in.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_new/authServices/googleIdentityAuthService/google_identity_auth.dart';

class GoogleIdentityAuthController {
  Future<Response> googlelogin(Request request) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    await signInWithGoogle(googleUser);

    return Response.ok('User Logged In',
        headers: {'content-type': 'application/json'});
  }

  Future<Response> googlelogout(Request request) async {
    await signOutWithGoogle();

    return Response.ok('User Logged Out',
        headers: {'content-type': 'application/json'});
  }
}
