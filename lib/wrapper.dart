import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<GalleryUser>(context);
    final user = null;
    if (user == null) {
      return MyLogin();
    } else {
      return Home();
    }
  }
}
