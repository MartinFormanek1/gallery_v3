import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/edit_image_crop.dart';
import 'package:gallery_v3/screens/edit_image_filter.dart';
import 'package:gallery_v3/screens/edit_image_screen.dart';
import 'package:gallery_v3/screens/error/error.dart';
import 'package:gallery_v3/screens/image_picker/my_image_picker.dart';
import 'package:gallery_v3/screens/log_reg/authentication.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:gallery_v3/screens/log_reg/register/register.dart';
import 'package:gallery_v3/screens/splash_screen/splash_screen.dart';
import 'package:gallery_v3/screens/user_follows/user_follows.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/screens/user_saved/user_saved.dart';
import 'package:gallery_v3/themes/custom_themes.dart';
import 'package:gallery_v3/wrapper.dart';
import 'package:provider/provider.dart';

import 'model/gallery_user.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorFirebase();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              child: MaterialApp(routes: {
                Login.routeName: (context) => Login(),
                Register.routeName: (context) => Register(),
                MyImagePicker.routeName: (context) => MyImagePicker(),
                MyGallery.routeName: (context) => MyGallery(),
                MySaved.routeName: (context) => MySaved(),
                MyFollows.routeName: (context) => MyFollows(),
                MyProfile.routeName: (context) => MyProfile(),
                EditImageScreen.routeName: (context) => EditImageScreen(),
                MyImageFilter.routeName: (context) => MyImageFilter(),
                MyImageCrop.routeName: (context) => MyImageCrop(),
              }, theme: CustomTheme.currentTheme, home: Wrapper()),
              providers: [
                StreamProvider<GalleryUser>.value(value: UserAuth().user)
              ],
            );
          }
          return SplashScreen();
        });
  }
}
