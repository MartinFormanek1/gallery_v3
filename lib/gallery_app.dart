import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/image_picker/my_image_picker.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:gallery_v3/screens/log_reg/register/register.dart';
import 'package:gallery_v3/screens/search_screen.dart';
import 'package:gallery_v3/screens/upload_image_screen.dart';
import 'package:gallery_v3/screens/user_follows/user_follows.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/foreign_user_profile.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/wrapper.dart';
import 'package:provider/provider.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({Key key}) : super(key: key);

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: _auth.userChanges(),
      child: MaterialApp(routes: {
        Home.routeName: (context) => Home(),
        ForeignUserScreen.routeName: (context) =>
            ForeignUserScreen(ModalRoute.of(context).settings.arguments),
        MySearch.routeName: (context) => MySearch(),
        MyLogin.routeName: (context) => MyLogin(),
        MyRegister.routeName: (context) => MyRegister(),
        MyImagePicker.routeName: (context) => MyImagePicker(),
        MyGallery.routeName: (context) => MyGallery(),
        //MySaved.routeName: (context) => MySaved(),
        MyFollows.routeName: (context) => MyFollows(),
        MyProfile.routeName: (context) => MyProfile(),
        UploadImageScreen.routeName: (context) => UploadImageScreen(),
      }, home: Wrapper()),
    );
  }
}
