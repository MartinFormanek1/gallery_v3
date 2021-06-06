import 'package:flutter/material.dart';

class IconFavButton extends StatefulWidget {
  @override
  _IconFavButtonState createState() => _IconFavButtonState();
}

class _IconFavButtonState extends State<IconFavButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite),
      color: _pressed ? Colors.red : Colors.black,
      onPressed: () {
        setState(() {
          _pressed = !_pressed;
        });
      },
    );
  }
}
