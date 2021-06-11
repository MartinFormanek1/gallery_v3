import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';

class MyFollows extends StatefulWidget {
  static const routeName = '/myFollows';
  const MyFollows({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyFollows(),
      );

  @override
  _MyFollowsState createState() => _MyFollowsState();
}

class _MyFollowsState extends State<MyFollows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Follows'),
      ),
      body: RaisedButton(
        onPressed: () => Navigator.of(context).pushReplacement(Home.route),
      ),
    );
  }
}
