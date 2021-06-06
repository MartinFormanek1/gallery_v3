import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_v3/components/filters.dart';

class MyImageFilters extends StatefulWidget {
  static const routeName = '/myImageFilters';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => MyImageFilters(),
      );

  File image;
  final List<List<double>> filters = [
    NO_FILTER,
    GRAYSCALE,
    SEPIUM,
    OLD_TIMES,
    MILK
  ];

  MyImageFilters({Key key, this.image}) : super(key: key);
  final GlobalKey _globalKey = GlobalKey();

  @override
  _MyImageFiltersState createState() => _MyImageFiltersState();
}

class _MyImageFiltersState extends State<MyImageFilters> {
  void convertWidgetToImage() async {
    RenderRepaintBoundary repaintBoundary =
        widget._globalKey.currentContext.findRenderObject();
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    PageController _pageControler = new PageController(
      keepPage: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a filter"),
      ),
      body: Column(children: [
        Container(
          child: RepaintBoundary(
            key: widget._globalKey,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width, maxHeight: size.height * 0.65),
              child: PageView.builder(
                  controller: _pageControler,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.filters.length,
                  itemBuilder: (context, index) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.matrix(widget.filters[index]),
                      child: Image.file(widget.image),
                    );
                  }),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.filters.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2.0),
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(widget.filters[index]),
                  child: GestureDetector(
                    onTap: () {
                      int i = 0;
                      while (i <= index) {
                        _pageControler.animateToPage(i,
                            curve: Curves.ease,
                            duration: Duration(milliseconds: 300));
                        i = i + 1;
                      }
                    },
                    child: Image.file(
                      widget.image,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
