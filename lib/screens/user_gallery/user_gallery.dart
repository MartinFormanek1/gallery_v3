import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';

class MyGallery extends StatefulWidget {
  static const routeName = '/myGallery';
  const MyGallery({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyGallery(),
      );

  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Gallery'),
      ),
      body: RaisedButton(
        onPressed: () => Navigator.of(context).pushReplacement(Home.route),
      ),
    );
  }
}
