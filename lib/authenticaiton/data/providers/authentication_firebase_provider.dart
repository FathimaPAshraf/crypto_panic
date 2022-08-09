import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFirebaseProvider {
  final FirebaseAuth _firebaseAuth;
  AuthenticationFirebaseProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Stream<User?> getAuthStates() {
    ///returns stream of users depending on state
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> login({
    ///Authenticate user with the credentials
    required AuthCredential credential,
  }) async {
    UserCredential userCredential =
    ///sign in the user using credentials
        await _firebaseAuth.signInWithCredential(credential);
    ///returns a firebase user
    return userCredential.user;
  }

  ///logout user using firebase auth
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
