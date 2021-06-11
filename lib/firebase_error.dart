import 'package:flutter/material.dart';
import 'package:gallery_v3/themes/custom_themes.dart';

class MyFirebaseError extends StatelessWidget {
  const MyFirebaseError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
        body: Center(
          child: Text('Error'),
        ),
      ),
    );
  }
}
