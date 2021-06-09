import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'model/gallery_user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GalleryUser>(context);
    if (user == null) {
      return Home();
    } else {
      return Home();
    }
  }
}
