import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key key, this.scaffoldKey, this.title, this.isBackArrow})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final bool isBackArrow;

  void _openEndDrawer() {
    scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBackArrow
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: ColorPallete.fullWhite),
              onPressed: () {
                Navigator.of(context).push(Home.route);
              })
          : null,
      backgroundColor: ColorPallete.vermillion,
      toolbarHeight: 70.0,
      shadowColor: CustomTheme.getTheme ? Colors.grey : null,
      elevation: 10,
      title: Text(title),
      actions: <Widget>[
        if (scaffoldKey != null)
          IconButton(
            onPressed: _openEndDrawer,
            icon: Icon(Icons.menu),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
