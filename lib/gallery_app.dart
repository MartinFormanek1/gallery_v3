import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/image_picker/my_image_picker.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:gallery_v3/screens/log_reg/register/register.dart';
import 'package:gallery_v3/screens/settings.dart';
import 'package:gallery_v3/screens/upload_image_screen.dart';
import 'package:gallery_v3/screens/user_follows/user_follows.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/screens/user_saved/user_saved.dart';
import 'package:gallery_v3/wrapper.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({Key key}) : super(key: key);

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      Home.routeName: (context) => Home(),
      MyLogin.routeName: (context) => MyLogin(),
      MyRegister.routeName: (context) => MyRegister(),
      MyImagePicker.routeName: (context) => MyImagePicker(),
      MyGallery.routeName: (context) => MyGallery(),
      MySaved.routeName: (context) => MySaved(),
      MyFollows.routeName: (context) => MyFollows(),
      MyProfile.routeName: (context) => MyProfile(),
      UploadImageScreen.routeName: (context) => UploadImageScreen(),
      MySettings.routeName: (context) => MySettings(),
    }, home: Wrapper());
  }
}
