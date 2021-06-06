import 'package:flutter/material.dart';

class ErrorFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Text("Something went wrong."),
          )
        ],
      ),
    ));
  }
}
