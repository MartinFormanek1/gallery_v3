import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_v3/components/tag_dialog.dart';
import 'package:gallery_v3/providers/my_image_provider.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();

  static const routeName = '/myUpload';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const UploadImageScreen(),
      );
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        MyImageProvider.instance.setImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Upload your image'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorPallete.fullWhite),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: ColorPallete.vermillion,
      ),
      body: GestureDetector(
        onTap: getImage,
        child: Center(
          child: SizedBox.expand(
            child: Container(
              child: MyImageProvider.instance.getImage == null
                  ? _buildText()
                  : Image.file(MyImageProvider.instance.getImage),
            ),
          ),
        ),
      ),
      floatingActionButton: MyImageProvider.instance.getImage == null
          ? null
          : FloatingActionButton(
              backgroundColor: ColorPallete.vermillion,
              onPressed: () => showDialog<void>(
                  context: context, builder: (context) => TagsDialog()),
              child: Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _buildText() {
  return _Text();
}

class _Text extends StatelessWidget {
  const _Text({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Tap to select your image',
          style: TextStyle(
            fontSize: 32,
            color: CustomTheme.reverseTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
