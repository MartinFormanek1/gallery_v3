import 'dart:io';

class MyImageProvider {
  //init singleton
  MyImageProvider._privateConstructor();
  static final MyImageProvider _instance =
      MyImageProvider._privateConstructor();
  static MyImageProvider get instance => _instance;

  File _originalImage;
  File get orgImage => _originalImage;
  set orgImage(File image) {
    _originalImage = image;
  }

  File _image;
  File get image => _image;
  set image(File image) {
    _image = image;
  }
}
