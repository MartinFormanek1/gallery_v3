import 'package:flutter/material.dart';
import 'package:gallery_v3/components/custom_appbar.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'My Profile',
        isBackArrow: true,
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(),
    );
  }
}
