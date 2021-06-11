import 'package:flutter/material.dart';
import 'package:gallery_v3/components/custom_appbar.dart';
import 'package:gallery_v3/components/likebtn.dart';
import 'package:gallery_v3/components/loading.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/screens/error/error.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/themes/custom_themes.dart';

class MyProfile extends StatefulWidget {
  static const routeName = '/myProfile';
  const MyProfile({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyProfile(),
      );

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DatabaseService db = DatabaseService();
  List images = [];

  void fillList() async {
    if (mounted) {
      List tempList = await db.getImages(images);
      setState(() {
        images = tempList;
      });
    }
  }

  load() {
    if (mounted) {
      fillList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'My Profile',
        isBackArrow: true,
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 24, 8, 0),
        child: Center(
          child: FutureBuilder(
            future: load(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return ErrorFirebase();
              if (images.isNotEmpty)
                return ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shadowColor:
                              CustomTheme.getTheme ? Colors.grey : null,
                          elevation: 10,
                          color: ColorPallete.vermillion,
                          child: Column(
                            children: [
                              Image.network(images[index]),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconFavButton(),
                                    Text("Posted by Martin"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              return Loading();
            },
          ),
        ),
      ),
    );
  }
}
