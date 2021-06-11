import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';

class MyProfile extends StatefulWidget {
  static const routeName = '/myProfile';
  const MyProfile({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyProfile(),
      );

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: RaisedButton(
        onPressed: () => Navigator.of(context).pushReplacement(Home.route),
      ),
    );
  }
}
