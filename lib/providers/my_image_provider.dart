import 'dart:io';

import 'package:gallery_v3/providers/my_tags_provider.dart';

class MyImageProvider {
  //init singleton
  MyImageProvider._privateConstructor();
  static final MyImageProvider _instance =
      MyImageProvider._privateConstructor();
  static MyImageProvider get instance => _instance;

  File _originalImage;
  File get getOrgImage => _originalImage;
  set setOrgImage(File image) {
    _originalImage = image;
  }

  List<Tag> _selectedTags;
  List<Tag> get getSelectedTags => _selectedTags;
  set setSelectedTags(List<Tag> tags) {
    _selectedTags = tags;
  }

  File _image;
  File get getImage => _image;

  set setImage(File image) {
    List<Tag> _tempTags = [];
    if (_selectedTags != null) {
      if (_selectedTags.isNotEmpty) {
        _selectedTags.forEach((tag) {
          tag.isSelected = false;
          _tempTags.add(tag);
        });
      }
    }
    _selectedTags.removeWhere((tag) => _tempTags.contains(tag));
    _image = image;
  }
}
