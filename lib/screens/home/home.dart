import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_v3/components/custom_appbar.dart';
import 'package:gallery_v3/components/main_feed.dart';
import 'package:gallery_v3/components/side_menu.dart';
import 'package:gallery_v3/screens/upload_image_screen.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';
import 'package:gallery_v3/wrapper.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  static const routeName = '/myHome';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const Home(),
      );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return Wrapper();
    }
    return Scaffold(
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
        title: 'Gallery',
        isBackArrow: false,
      ),
      body: MainFeed(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.vermillion,
        onPressed: () => Navigator.push(
            context,
            PageTransition(
                child: UploadImageScreen(), type: PageTransitionType.fade)),
        child: Icon(Icons.add),
      ),
      endDrawer: SideSheet(),
    );
  }
}
