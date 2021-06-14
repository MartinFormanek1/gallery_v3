import 'package:flutter/material.dart';
import 'package:gallery_v3/components/side_menu_button.dart';
import 'package:gallery_v3/database/user_login.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:gallery_v3/screens/search_screen.dart';
import 'package:gallery_v3/screens/user_follows/user_follows.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';

class SideSheet extends StatefulWidget {
  const SideSheet({Key key, this.off}) : super(key: key);
  @override
  _SideSheetState createState() => _SideSheetState();
  final String off;
}

class _SideSheetState extends State<SideSheet> {
  final UserLogin _auth = UserLogin();

  void signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: size.width * 0.5,
        child: Drawer(
          child: Container(
            color: CustomTheme.currentTheme.scaffoldBackgroundColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorPallete.vermillion,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SideButton(
                        route: () {
                          setState(() {
                            signOut();
                            Navigator.push(context, MyLogin.route);
                          });
                        },
                        icon: Icon(Icons.logout),
                        label: 'Log Out',
                        color: ColorPallete.fullWhite,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView(
                        padding: EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SideButton(
                            alignment: Alignment.centerLeft,
                            route: widget.off != 'search'
                                ? () =>
                                    Navigator.of(context).push(MySearch.route)
                                : null,
                            icon: Icon(Icons.search),
                            label: 'Search',
                            color: widget.off != 'search'
                                ? CustomTheme.reverseTextColor
                                : CustomTheme.getDisabledColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SideButton(
                            alignment: Alignment.centerLeft,
                            route: widget.off != 'profile'
                                ? () =>
                                    Navigator.of(context).push(MyProfile.route)
                                : null,
                            icon: Icon(Icons.person),
                            label: 'Visit Profile',
                            color: widget.off != 'profile'
                                ? CustomTheme.reverseTextColor
                                : CustomTheme.getDisabledColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SideButton(
                            alignment: Alignment.centerLeft,
                            route: widget.off != 'gallery'
                                ? () =>
                                    Navigator.of(context).push(MyGallery.route)
                                : null,
                            icon: Icon(Icons.image),
                            label: 'My gallery',
                            color: widget.off != 'gallery'
                                ? CustomTheme.reverseTextColor
                                : CustomTheme.getDisabledColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SideButton(
                            alignment: Alignment.centerLeft,
                            route: widget.off != 'follows'
                                ? () =>
                                    Navigator.of(context).push(MyFollows.route)
                                : null,
                            icon: Icon(Icons.bookmark),
                            label: 'My Follows',
                            color: CustomTheme.reverseTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: CustomTheme.reverseThemeColor.scaffoldBackgroundColor,
                  height: 0,
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: CustomTheme.getTheme
                        ? ColorPallete.settingsBarWhite
                        : ColorPallete.settingsBarBlack,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            CustomTheme.changeTheme(context);
                          });
                        },
                        icon: Icon(
                          CustomTheme.getTheme
                              ? Icons.brightness_2_outlined
                              : Icons.brightness_2,
                          color: CustomTheme.getTheme
                              ? ColorPallete.fullBlack
                              : ColorPallete.vermillion,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
