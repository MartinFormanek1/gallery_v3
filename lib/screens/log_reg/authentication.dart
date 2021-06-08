import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/model/gallery_user.dart';

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GalleryUser _userFromFBUser(User user) {
    return (user != null) ? GalleryUser(uid: user.uid) : null;
  }

  Stream<GalleryUser> get user {
    return _auth.authStateChanges().map(_userFromFBUser);
  }

  Future<GalleryUser> registerWithEmailPassword(
      String email, String password, String username) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(username);
      return _userFromFBUser(user);
    } catch (e) {
      print("Error + " + e);
      return null;
    }
  }

  Future signInWithEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFBUser(user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
