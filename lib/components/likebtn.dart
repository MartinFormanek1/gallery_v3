import 'package:flutter/material.dart';
import 'package:gallery_v3/styles/colors.dart';

class IconFavButton extends StatefulWidget {
  @override
  _IconFavButtonState createState() => _IconFavButtonState();
}

class _IconFavButtonState extends State<IconFavButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Stack(
          children: [
            Positioned(
              left: -3,
              top: -3,
              child: Icon(
                Icons.favorite_sharp,
                size: 34,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.favorite_sharp,
              size: 28,
            ),
          ],
        ),
        color: _pressed ? ColorPallete.likeRed : Colors.black,
        onPressed: () {
          setState(() {
            _pressed = !_pressed;
          });
        },
      ),
    );
  }
}
