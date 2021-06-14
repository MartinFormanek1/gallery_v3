import 'package:flutter/material.dart';
import 'package:gallery_v3/components/like_button.dart';
import 'package:gallery_v3/components/loading.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

class ForeignUserScreen extends StatefulWidget {
  static const routeName = '/foreignUser';

  ForeignUserScreen(this.username);

  @override
  _ForeignUserScreenState createState() => _ForeignUserScreenState();

  final username;
}

class _ForeignUserScreenState extends State<ForeignUserScreen> {
  DatabaseService db = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _imageUrls = [];
  List<String> _posters = [];
  List<bool> _isLiked = [];
  String currentUser = '';

  @override
  void initState() {
    super.initState();
    fillList();
  }

  load() {
    if (mounted) {
      Future.delayed(Duration(seconds: 3), () => fillList());
    }
  }

  void fillList() async {
    await db.initData();
    _imageUrls = await db.getForeignUrls(widget.username);
    _isLiked = await db.isForeignLikedByCurrentUser(_imageUrls);
    currentUser = await db.getUsername();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${widget.username}'s profile"),
        backgroundColor: ColorPallete.vermillion,
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
                            Stack(
                              children: [
                                Image.network(_imageUrls[index]),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.username != currentUser
                                          ? ColorPallete.vermillion
                                          : ColorPallete.disabledLight,
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      onPressed: widget.username != currentUser
                                          ? () => db.addFollow(widget.username)
                                          : null,
                                      icon: Icon(Icons.person_add),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 55,
                                  left: 295,
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.username != currentUser
                                          ? ColorPallete.vermillion
                                          : ColorPallete.disabledLight,
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      onPressed: () =>
                                          db.addSaved(_imageUrls[index]),
                                      icon: Icon(Icons.bookmark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                          widget.username, _imageUrls[index]);
                                    },
                                    pressed: _isLiked[index],
                                  ),
                                  Text("Posted by ${widget.username}"),
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
    );
  }
}
