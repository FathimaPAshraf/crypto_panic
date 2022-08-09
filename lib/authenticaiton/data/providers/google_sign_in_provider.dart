import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// to sign in with google

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn;
  GoogleSignInProvider({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;


  // google sign in, authentication, login
  Future<AuthCredential> login() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return authCredential;
  }
//logout user from google
  Future<void> logout() async {
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }
  }
}
