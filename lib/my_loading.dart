import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_v3/styles/colors.dart';

class MyLoading extends StatefulWidget {
  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPallete.fullWhite,
        body: Center(
          child: Stack(
            children: [
              Positioned(
                child: SpinKitPulse(
                  size: 1000,
                  color: ColorPallete.logoOrange,
                ),
              ),
              Center(
                child: Image.asset("assets/images/launch_image.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
