import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_v3/styles/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: ColorPallete.appbarColor,
      size: 50,
    );
  }
}
