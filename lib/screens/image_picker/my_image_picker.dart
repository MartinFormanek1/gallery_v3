import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gallery_v3/screens/edit_image_filter.dart';
import 'package:gallery_v3/shared/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MyImagePicker extends StatefulWidget {
  static const routeName = '/myImagePicker';
  @override
  _MyImagePickerState createState() => _MyImagePickerState();

  const MyImagePicker({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyImagePicker(),
      );
}

class _MyImagePickerState extends State<MyImagePicker> {
  var user = FirebaseAuth.instance.currentUser;

  File _image;
  final picker = ImagePicker();
  final FirebaseFirestore fb = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('images');

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Your Image'),
      ),
      body: SizedBox.expand(
        child: Container(
          child: FittedBox(
            child: _image == null
                ? Text(' No image selected. ')
                : Image.file(_image),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: ColorPallete.floatingActionButtonColor,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.image),
            backgroundColor: ColorPallete.floatingActionButtonColor,
            onTap: () => getImage(),
            label: 'Pick Image',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: ColorPallete.floatingActionButtonColor,
          ),
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: ColorPallete.floatingActionButtonColor,
            onTap: () => (_image == null)
                ? null
                : Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyImageFilter())),
            label: 'Edit Image',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: ColorPallete.floatingActionButtonColor,
          ),
          SpeedDialChild(
            child: Icon(Icons.send),
            backgroundColor: ColorPallete.floatingActionButtonColor,
            onTap: () {
              setState(() async {
                if (_image != null) {
                  String fileName = basename(_image.path);

                  firebase_storage.SettableMetadata metadata =
                      firebase_storage.SettableMetadata(
                    customMetadata: <String, String>{
                      'userId': user.uid,
                    },
                  );

                  try {
                    await firebase_storage.FirebaseStorage.instance
                        .ref('images/$fileName')
                        .putFile(_image, metadata);
                  } catch (e) {
                    print(e);
                  } finally {
                    Navigator.pop(context);
                  }
                }
              });
            },
            label: 'Upload',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: ColorPallete.floatingActionButtonColor,
          ),
        ],
      ),
    );
  }
}
