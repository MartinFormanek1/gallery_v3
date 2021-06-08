import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/edit_image_screen.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:provider/provider.dart';

import 'model/gallery_user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GalleryUser>(context);
    if (user == null) {
      return Login();
    } else {
      return EditImageScreen();
    }
  }
}
