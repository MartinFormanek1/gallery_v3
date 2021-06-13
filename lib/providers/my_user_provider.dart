import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {
  //init singleton
  UserProvider._privateConstructor();
  static final UserProvider _instance = UserProvider._privateConstructor();
  static UserProvider get instance => _instance;

  User _user;
  get getUser {
    return _user;
  }

  set setUser(User user) {
    _user = user;
  }

  void initUser() {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _user = user;
    }
  }
}
