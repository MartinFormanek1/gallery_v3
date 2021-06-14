import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/components/search_tag_dialog.dart';
import 'package:gallery_v3/database/database_service.dart';
import 'package:gallery_v3/database/search_service.dart';
import 'package:gallery_v3/screens/user_profile/foreign_user_profile.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

import 'home/home.dart';

class MySearch extends StatefulWidget {
  const MySearch({Key key}) : super(key: key);
  static const routeName = '/mySearch';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MySearch(),
      );

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SearchService sc = SearchService();

  List<String> _users = [];

  DatabaseService db = DatabaseService();
  List<String> _imageUrls = [];
  List<String> _posters = [];
  List<bool> _isLiked = [];
  String currentUser = '';

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  Widget body = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton()
            : IconButton(
                icon: Icon(Icons.arrow_back, color: ColorPallete.fullWhite),
                onPressed: () {
                  Navigator.of(context).push(Home.route);
                }),
        title: _isSearching ? _buildSearchField() : Text('Search'),
        actions: _buildActions(),
        backgroundColor: ColorPallete.vermillion,
      ),
      body: body,
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Users...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
        icon: Icon(Icons.filter_alt),
        onPressed: () {
          _stopSearching();
          showDialog<List<String>>(
              context: context,
              builder: (context) => SearchTagDialog()).then((_tags) {
            _buildImages(_tags ?? []);
            setState(() {});
          });
        },
      ),
    ];
  }

  Future _buildImages(List<String> _tags) async {
    _imageUrls = await sc.getImages(_tags) ?? [];
    _posters = await sc.getImagePoster(_imageUrls);
    _isLiked = await sc.isLikedByCurrentUser(_imageUrls);
    currentUser = await db.getUsername();
    body = _buildImagesBody(_tags);
    setState(() {});
  }

  Widget _buildImagesBody(List<String> _tags) {
    if (_tags.isEmpty) {
      return Center(child: Text('Empty'));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(8, 24, 8, 0),
      child: Center(
          child: ListView.builder(
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
                                  color: _posters[index] != currentUser
                                      ? ColorPallete.vermillion
                                      : ColorPallete.disabledLight,
                                ),
                                height: 50,
                                width: 50,
                                child: IconButton(
                                  onPressed: _posters[index] != currentUser
                                      ? () => db.addFollow(_posters[index])
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
                                  color: _posters[index] != currentUser
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Stack(
                                  children: [
                                    Positioned(
                                      left: -3,
                                      top: -3,
                                      child: Icon(
                                        Icons.favorite_sharp,
                                        size: 34,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite_sharp,
                                      size: 28,
                                    ),
                                  ],
                                ),
                                color: _isLiked[index]
                                    ? ColorPallete.likeRed
                                    : Colors.black,
                                onPressed: () {
                                  db.addLike(
                                      _posters[index], _imageUrls[index]);
                                  _buildImages(_tags);
                                  setState(() {});
                                },
                              ),
                              Text("Posted by ${_posters[index] ?? '####'}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Future _buildUsers() async {
    if (searchQuery == '') {
      return null;
    }
    _users = await _getUsers();
    body = _buildUserBody();
  }

  Widget _buildUserBody() {
    return FutureBuilder(
        future: _buildUsers(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorPallete.vermillion,
                      width: 1,
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  title: Text(
                    '${_users[index]}',
                    style: TextStyle(
                      color: CustomTheme.reverseTextColor,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForeignUserScreen.routeName,
                          arguments: _users[index]);
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp),
                    color: ColorPallete.vermillion,
                  ),
                ),
              );
            },
          );
        });
  }

  Future<List<String>> _getUsers() async {
    List<String> _users = await sc.searchUsers(searchQuery);
    return _users;
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
      _buildUsers();
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      _buildUsers();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
