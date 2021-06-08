// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:gallery_v3/providers/my_image_provider.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../providers/my_filter_provider.dart';
//
// class ImageFilter extends StatelessWidget {
//   final GlobalKey _globalKey = GlobalKey();
//
//   Future<File> convertWidgetToFile() async {
//     RenderRepaintBoundary repaintBoundary =
//         _globalKey.currentContext.findRenderObject();
//     ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
//     ByteData byteData = await boxImage.toByteData(
//       format: ui.ImageByteFormat.png,
//     );
//     Uint8List uint8list = byteData.buffer.asUint8List();
//
//     String tempPath = (await getTemporaryDirectory()).path;
//     File file = await File('$tempPath/temp.png').writeAsBytes(uint8list);
//     return file;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     PageController _pageControler = new PageController(
//       keepPage: true,
//     );
//
//     return Column(children: [
//       Container(
//         child: RepaintBoundary(
//           key: _globalKey,
//           child: Container(
//             constraints: BoxConstraints(
//                 maxWidth: size.width, maxHeight: size.height * 0.65),
//             child: PageView.builder(
//                 controller: _pageControler,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: MyFilterProvider.instance.filters.length,
//                 itemBuilder: (context, index) {
//                   return ColorFiltered(
//                     colorFilter: ColorFilter.matrix(
//                         MyFilterProvider.instance.filters[index]),
//                     child: GestureDetector(
//                         onTap: () async {
//                           MyImageProvider.instance.image =
//                               await convertWidgetToFile();
//                         },
//                         child: Image.file(MyImageProvider.instance.image)),
//                   );
//                 }),
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 100,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: MyFilterProvider.instance.filters.length,
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                   border: Border(
//                       right: BorderSide(
//                           width: (index ==
//                                   MyFilterProvider.instance.filters.length - 1)
//                               ? 0
//                               : 1.0,
//                           color: Colors.black))),
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.matrix(
//                     MyFilterProvider.instance.filters[index]),
//                 child: GestureDetector(
//                   onTap: () {
//                     int i = 0;
//                     while (i <= index) {
//                       _pageControler.animateToPage(i,
//                           curve: Curves.ease,
//                           duration: Duration(milliseconds: 1300));
//                       i = i + 1;
//                     }
//                   },
//                   child: Image.file(
//                     MyImageProvider.instance.image,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     ]);
//   }
// }
