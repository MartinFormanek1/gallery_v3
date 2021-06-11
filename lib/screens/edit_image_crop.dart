import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_v3/providers/my_image_provider.dart';
import 'package:image_crop/image_crop.dart';
import 'package:path_provider/path_provider.dart';

class MyImageCrop extends StatefulWidget {
  const MyImageCrop({Key key}) : super(key: key);

  static const routeName = '/cropImageScreen';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => MyImageCrop(),
      );

  @override
  _MyImageCropState createState() => _MyImageCropState();
}

class _MyImageCropState extends State<MyImageCrop> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void initState() {
    super.initState();
    _sample = MyImageProvider.instance.image;
    _file = MyImageProvider.instance.image;
    print(MyImageProvider.instance.image);
    //_openImage();
  }

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return TextButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(),
    );
  }

  Future<void> _openImage() async {
    final sample = await ImageCrop.sampleImage(
      file: MyImageProvider.instance.image,
      preferredSize: context.size.longestSide.ceil(),
    );

    //_sample?.delete();
    //_file?.delete();

    setState(() {
      _sample = sample;
      _file = MyImageProvider.instance.image;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path + "/";

    _lastCropped = await moveFile(_lastCropped, appDocPath);

    MyImageProvider.instance.image = _lastCropped;

    Navigator.of(context).pop();
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    final newFile =
        await sourceFile.copy(newPath + sourceFile.path.substring(41));
    await sourceFile?.delete();
    return newFile;
  }
}
