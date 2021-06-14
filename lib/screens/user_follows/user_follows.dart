import 'package:flutter/material.dart';
import 'package:gallery_v3/components/custom_appbar.dart';
import 'package:gallery_v3/components/like_button.dart';
import 'package:gallery_v3/components/loading.dart';
import 'package:gallery_v3/components/side_menu.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/database/search_service.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

class MyFollows extends StatefulWidget {
  const MyFollows({Key key}) : super(key: key);

  static const routeName = '/myFollows';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyFollows(),
      );

  @override
  _MyFollowsState createState() => _MyFollowsState();
}

class _MyFollowsState extends State<MyFollows> {
  DatabaseService db = DatabaseService();
  SearchService sc = SearchService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _imageUrls = [];
  List<String> _posters = [];
  List<bool> _isLiked = [];
  String _username = '';

  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    if (mounted) {
      Future.delayed(Duration(seconds: 3), () => fillList());
    }
  }

  void fillList() async {
    await db.initData();
    _username = await db.getUsername();
    _imageUrls = await db.getFollowUrls();
    _isLiked = await db.isForeignLikedByCurrentUser(_imageUrls);
    _posters = await sc.getImagePoster(_imageUrls);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'My Gallery',
        isBackArrow: true,
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 24, 8, 0),
        child: Center(
          child: FutureBuilder(
            future: load(),
            builder: (context, snapshot) {
              if (_imageUrls.isNotEmpty)
                return ListView.builder(
                  itemCount: _imageUrls.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: CustomTheme.getTheme ? Colors.grey : null,
                        elevation: 10,
                        color: ColorPallete.vermillion,
                        child: Column(
                          children: [
                            Image.network(_imageUrls[index]),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconFavButton(
                                    addLike: () {
                                      db.addLike(_username, _imageUrls[index]);
                                    },
                                    pressed: _isLiked[index],
                                  ),
                                  Text("Posted by ${_posters[index]}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              return Loading();
            },
          ),
        ),
      ),
      endDrawer: SideSheet(off: 'profile'),
    );
  }
}
