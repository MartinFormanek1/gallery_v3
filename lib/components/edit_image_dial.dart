import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gallery_v3/shared/colors.dart';

class EditDial extends StatelessWidget {
  final Function _selectFilters;

  EditDial(
    this._selectFilters,
  );

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: ColorPallete.floatingActionButtonColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.filter_alt),
          backgroundColor: ColorPallete.floatingActionButtonColor,
          onTap: _selectFilters,
          label: 'Filters',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: ColorPallete.floatingActionButtonColor,
        ),
      ],
    );
  }
}
