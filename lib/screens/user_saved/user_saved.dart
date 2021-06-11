import 'package:flutter/material.dart';

class MySaved extends StatefulWidget {
  static const routeName = '/mySaved';
  const MySaved({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MySaved(),
      );

  @override
  _MySavedState createState() => _MySavedState();
}

class _MySavedState extends State<MySaved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Saved'),
      ),
    );
  }
}
