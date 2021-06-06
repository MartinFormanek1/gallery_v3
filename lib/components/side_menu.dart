import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/log_reg/authentication.dart';
import 'package:gallery_v3/screens/user_follows/user_follows.dart';
import 'package:gallery_v3/screens/user_gallery/user_gallery.dart';
import 'package:gallery_v3/screens/user_profile/user_profile.dart';
import 'package:gallery_v3/screens/user_saved/user_saved.dart';

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
          padding: EdgeInsets.all(8),
          color: Colors.brown[100],
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MyProfile.route),
                    label: Text('Visit Profile'),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      setState(() {
                        _auth.signOut();
                      });
                    },
                    label: Text('Log Out'),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 15,
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
                        FlatButton.icon(
                          icon: Icon(Icons.image),
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MyGallery.route),
                          label: Text('My gallery'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.people),
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MyFollows.route),
                          label: Text('Follows'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.bookmark),
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MySaved.route),
                          label: Text('Saved'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /*FlatButton.icon(
                          icon: Icon(Icons.adb_sharp),
                          onPressed: () {},
                          label: Text('Password Reset'),
                        ),*/
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 15,
              ),
              Row(
                children: [
                  Align(
                    child: FlatButton.icon(
                      icon: Icon(Icons.settings),
                      onPressed: () {},
                      label: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
