import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegistration {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<User> registerWithEmailPassword(
    String email,
    String password,
    String username,
  ) async {
    try {
      List<String> usernames = await fetchUsernames();
      if (usernames.contains(username)) {
        return null;
      } else {
        final UserCredential result = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user;
        updateUserAfterReg(username, email, user.uid);
        return user;
      }
    } catch (e) {
      print("Error + " + e.toString());
      return null;
    }
  }

  Future updateUserAfterReg(
    String username,
    String email,
    String uID,
  ) async {
    return await users.doc(uID).set({
      'username': username,
      'email': email,
      'uID': uID,
      'follows': [],
      'saved': [],
    });
  }

  Future<List<String>> fetchUsernames() async {
    QuerySnapshot snapshot = await users.get();
    final data = snapshot.docs.map((doc) => doc.data()).toList();

    List<String> usernames = [];
    if (data != null) {
      data.forEach((doc) {
        usernames.add(doc['username']);
      });
    }
    return usernames;
  }
}
