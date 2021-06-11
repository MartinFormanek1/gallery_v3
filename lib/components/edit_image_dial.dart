import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gallery_v3/screens/edit_image_crop.dart';
import 'package:gallery_v3/screens/edit_image_filter.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:page_transition/page_transition.dart';

class EditDial extends StatelessWidget {
  final Function function;
  EditDial({this.function});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: ColorPallete.vermillion,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.filter_alt),
          backgroundColor: ColorPallete.vermillion,
          onTap: () => Navigator.push(
            context,
            PageTransition(
                child: MyImageFilter(), type: PageTransitionType.fade),
          ).then((value) {
            function;
          }),
          label: 'Filters',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: ColorPallete.vermillion,
        ),
        SpeedDialChild(
          child: Icon(Icons.crop),
          backgroundColor: ColorPallete.vermillion,
          onTap: () => Navigator.push(
            context,
            PageTransition(child: MyImageCrop(), type: PageTransitionType.fade),
          ).then((value) {
            function;
          }),
          label: 'Crop',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: ColorPallete.vermillion,
        ),
      ],
    );
  }
}
