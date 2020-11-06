import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:quiz_maker/models/user.dart';

class AuthService {
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User _userFromFirebaseUser(auth.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String password) async {
    try {
      auth.UserCredential _userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      auth.User _firebaseUser = _userCredential.user;
      return _userFromFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User _firebaseUser = _userCredential.user;
      return _userFromFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
