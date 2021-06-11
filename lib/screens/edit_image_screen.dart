import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_v3/components/edit_image_dial.dart';
import 'package:gallery_v3/providers/my_image_provider.dart';
import 'package:gallery_v3/styles/colors.dart';
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
  // final FirebaseFirestore fb = FirebaseFirestore.instance;
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  // firebase_storage.Reference ref =
  //     firebase_storage.FirebaseStorage.instance.ref('images');

  // Getting image.
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        MyImageProvider.instance.image = File(pickedFile.path);
        MyImageProvider.instance.orgImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.vermillion,
        title: Text((MyImageProvider.instance.image == null)
            ? 'Pick your image'
            : 'Your image'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  print(MyImageProvider.instance.image);
                });
              },
              child: Text('reset'))
        ],
      ),
      body: GestureDetector(
          onTap: () => getImage(),
          child: SizedBox.expand(
            child: Container(
                child: FittedBox(
              child: MyImageProvider.instance.image == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Tap to select \n your image.'),
                    )
                  : Image.file(MyImageProvider.instance.image),
            )),
          )),
      floatingActionButton: MyImageProvider.instance.image == null
          ? null
          : EditDial(function: () {
              setState(() {});
            }),
    );
  }
}
