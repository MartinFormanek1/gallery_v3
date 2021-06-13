import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';

class Wrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.uid);
            return Home();
          }
          return MyLogin();
        });
  }
}
