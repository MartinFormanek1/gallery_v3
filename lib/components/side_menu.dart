import 'package:flutter/material.dart';
import 'package:gallery_v3/components/side_menu_button.dart';
import 'package:gallery_v3/screens/log_reg/authentication.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/screens/user_saved/user_saved.dart';
import 'package:gallery_v3/shared/colors.dart';
import 'package:gallery_v3/themes/custom_themes.dart';

class SideSheet extends StatefulWidget {
  @override
  _SideSheetState createState() => _SideSheetState();
}

class _SideSheetState extends State<SideSheet> {
  final UserAuth _auth = UserAuth();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          _auth.signOut();
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
                        SideButton(
                          route: () => Navigator.of(context)
                              .pushReplacement(MyProfile.route),
                          icon: Icon(Icons.person),
                          label: 'Visit Profile',
                          color: ColorPallete.fullWhite,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SideButton(
                          route: () => Navigator.of(context)
                              .pushReplacement(MyGallery.route),
                          icon: Icon(Icons.image),
                          label: 'My gallery',
                          color: CustomTheme.reverseTextColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SideButton(
                          route: () => Navigator.of(context)
                              .pushReplacement(MySaved.route),
                          icon: Icon(Icons.bookmark),
                          label: 'Saved',
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
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SideButton(
                          route: () {},
                          icon: Icon(Icons.settings),
                          label: 'Settings',
                          color: CustomTheme.reverseTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
