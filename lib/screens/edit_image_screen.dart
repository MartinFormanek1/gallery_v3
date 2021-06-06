import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gallery_v3/components/edit_image_dial.dart';
import 'package:gallery_v3/components/edit_image_filters.dart';
import 'package:image_picker/image_picker.dart';

class EditImageScreen extends StatefulWidget {
  // Route pro edit_image_screen.
  static const routeName = '/editImageScreen';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => EditImageScreen(),
      );

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  _EditImageScreenState() {
    _title = 'Pick your image';
    generateScafBody();
  }

  // Variables
  String _title = "";
  File _image;
  Widget scafBody;
  bool editing = false;

  final FirebaseFirestore fb = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('images');

  // Getting image.
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _title = 'Edit your image';
      }
    });
  }

  selectFilters() {
    setState(() {
      _title = 'Select your filter';
      generateScafBody(body: ImageFilter(_image));
      editing = true;
    });
  }

  generateScafBody({Widget body}) {
    if (body == null) {
      scafBody = GestureDetector(
          onTap: () => getImage(),
          child: SizedBox.expand(
            child: Container(
                child: FittedBox(
              child: _image == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Tap to select \n your image.'),
                    )
                  : Image.file(_image),
            )),
          ));
    } else {
      scafBody = body;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (scafBody == null) {
      generateScafBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: scafBody,
      floatingActionButton: (_image == null) ? null : EditDial(selectFilters),
    );
  }
}

enum States { pick, edit, tag, send }
