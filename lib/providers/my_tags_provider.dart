import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_v3/styles/colors.dart';

class Tags {
  //init singleton
  Tags._privateConstructor();
  static final Tags _instance = Tags._privateConstructor();
  static Tags get instance => _instance;

  List<Tag> _tags = [
    Tag('Nature', Colors.green, Colors.green.shade900),
    Tag('Water', Colors.blue, Colors.blue.shade900),
    Tag('Dark', Colors.grey, ColorPallete.fullBlack),
    Tag('Animal', Colors.brown, Colors.brown.shade900),
    Tag('Abstract', Colors.white, Colors.grey),
    Tag('Fire', Colors.red, Colors.red.shade900),
    Tag('Space', Colors.lightBlue, Color(0xFF0E1428)),
    Tag('Light', Colors.yellowAccent, Colors.yellowAccent.shade700),
    Tag('Photo', Colors.orangeAccent, Colors.orange),
    Tag('Masterpiece', Colors.lightBlue, Colors.orange),
    Tag('Car', ColorPallete.silver, ColorPallete.dimGray),
    Tag('Aesthetic', Colors.purpleAccent, Colors.purple),
  ];

  List<Tag> get getTags {
    return _tags;
  }
}

class Tag {
  String value;
  Color c1;
  Color c2;
  bool isSelected;

  Tag(this.value, this.c1, this.c2, [this.isSelected = false]);
}
