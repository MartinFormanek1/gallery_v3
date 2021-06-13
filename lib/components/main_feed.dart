import 'package:flutter/material.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/screens/error/error.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

import 'like_button.dart';
import 'loading.dart';

class MainFeed extends StatefulWidget {
  const MainFeed({Key key}) : super(key: key);

  @override
  _MainFeedState createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  DatabaseService db = DatabaseService();
  List<String> _imageUrls = [];
  List<String> _posters = [];
  List<bool> _isLiked = [];

  void fillList() async {
    await db.initData();
    _posters = await db.getImagePoster();
    _isLiked = await db.isLikedByCurrentUser();
    setState(() {
      _imageUrls = db.getUrls();
    });
  }

  load() {
    if (mounted) {
      Future.delayed(Duration(seconds: 3), () => fillList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 24, 8, 0),
      child: Center(
        child: FutureBuilder(
          future: load(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return ErrorFirebase();
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
                                      db.addLike(
                                          _posters[index], _imageUrls[index]);
                                    },
                                    pressed: _isLiked[index],
                                  ),
                                  Text("Posted by ${_posters[index]}"),
                                ],
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    );
                  });
            return Loading();
          },
        ),
      ),
    );
  }
}
