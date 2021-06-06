import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';

class MySaved extends StatefulWidget {
  static const routeName = '/myGallery';
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
      body: RaisedButton(
        onPressed: () => Navigator.of(context).pushReplacement(Home.route),
      ),
    );
  }
}
