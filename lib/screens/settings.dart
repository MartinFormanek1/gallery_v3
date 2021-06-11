import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/components/custom_appbar.dart';
import 'package:gallery_v3/components/side_menu.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/themes/custom_themes.dart';

class MySettings extends StatefulWidget {
  const MySettings({Key key}) : super(key: key);

  static const routeName = '/mySettings';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MySettings(),
      );

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        scaffoldKey: null,
        title: 'Settings',
        isBackArrow: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: ColorPallete.vermillion),
            child: Transform.scale(
              scale: 1.2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CheckboxListTile(
                    value: !CustomTheme.getTheme,
                    activeColor: ColorPallete.vermillion,
                    checkColor: ColorPallete.fullWhite,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: CustomTheme.getTheme
                            ? ColorPallete.fullBlack
                            : ColorPallete.fullWhite,
                        fontSize: 12,
                      ),
                    ),
                    onChanged: (bool value) {
                      setState(() {
                        CustomTheme.changeTheme();
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
      endDrawer: SideSheet(),
    );
  }
}
