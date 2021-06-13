import 'dart:io';

import 'package:gallery_v3/providers/my_tags_provider.dart';

class MyImageProvider {
  //init singleton
  MyImageProvider._privateConstructor();
  static final MyImageProvider _instance =
      MyImageProvider._privateConstructor();
  static MyImageProvider get instance => _instance;

  List<Tag> _selectedTags;
  List<Tag> get getSelectedTags => _selectedTags;
  set setSelectedTags(List<Tag> tags) {
    _selectedTags = tags;
  }

  String tagValues() {
    String tagValues = "";

    print("-----------------------------------------------------");
    _selectedTags.forEach((element) => print(element));
    print("-----------------------------------------------------");

    for (int i = 0; i < _selectedTags.length; i++) {
      if (i == _selectedTags.length - 1) {
        tagValues += _selectedTags[i].value;
      } else {
        tagValues += _selectedTags[i].value + ', ';
      }
    }
    return tagValues;
  }

  File _image;
  File get getImage => _image;

  set setImage(File image) {
    _clearTag();
    _image = image;
  }

  void clearImage() {
    _clearTag();
    if (getImage != null) {
      setImage = null;
    }
  }

  void _clearTag() {
    List<Tag> _tempTags = [];
    if (_selectedTags != null) {
      if (_selectedTags.isNotEmpty) {
        _selectedTags.forEach((tag) {
          tag.isSelected = false;
          _tempTags.add(tag);
        });
      }
      _selectedTags.removeWhere((tag) => _tempTags.contains(tag));
    }
  }
}
