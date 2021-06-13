import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/firebase_error.dart';
import 'package:gallery_v3/gallery_app.dart';
import 'package:gallery_v3/my_loading.dart';
import 'package:gallery_v3/styles/custom_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseService db;
  bool _initialized = false;
  bool _error = false;

  Future initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      initImages();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () => initializeFirebase());
    initTheme();
    super.initState();
  }

  void initImages() async {
    db = DatabaseService();
    await db.initData();
  }

  void initTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLight = prefs.getBool('lightTheme');
    CustomTheme.onInitApp = isLight == null ? true : isLight;
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return MyFirebaseError();
    }

    if (!_initialized) {
      return MyLoading();
    }

    return GalleryApp();
  }
}
