import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_v3/components/likebtn.dart';
import 'package:gallery_v3/components/loading.dart';
import 'package:gallery_v3/components/side_menu.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/screens/edit_image_screen.dart';
import 'package:gallery_v3/screens/error/error.dart';
import 'package:gallery_v3/screens/log_reg/authentication.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const Home(),
      );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  Future load() {
    if (mounted) {
      fillList();
    }
  }

  getImageUser(var img) {
    return db.getImageUser(img);
  }

  final UserAuth _auth = UserAuth();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('Gallery'),
        actions: <Widget>[
          IconButton(
            onPressed: _openEndDrawer,
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      //body: Column(),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 24, 8, 0),
        child: Center(
          child: FutureBuilder(
            future: load(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorFirebase();
              }
              if (images.isNotEmpty) {
                return ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.brown,
                          shape:
                              Border(bottom: BorderSide(color: Colors.brown)),
                          child: Column(
                            children: [
                              Image.network(images[index]),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconFavButton(),
                                    Text("Posted by ####"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Loading();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            PageTransition(
                child: EditImageScreen(), type: PageTransitionType.fade)),
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
      endDrawer: SideSheet(),
    );
    /*,
    );*/
  }
}
