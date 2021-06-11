import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_v3/styles/colors.dart';

class Tags {
  //init singleton
  Tags._privateConstructor();
  static final Tags _instance = Tags._privateConstructor();
  static Tags get instance => _instance;

  List<Tag> _tags = [
    Tag('NSFW', Colors.red, Colors.red.shade900),
    Tag('Nature', Colors.green, Colors.green.shade900),
    Tag('Water', Colors.blue, Colors.blue.shade900),
    Tag('Dark', Colors.grey, ColorPallete.fullBlack),
    Tag('Animal', Colors.brown, Colors.brown.shade900),
    Tag('Asian', Colors.yellow, Colors.yellow.shade900),
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
