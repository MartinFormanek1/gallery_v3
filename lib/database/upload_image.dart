import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_v3/providers/my_image_provider.dart';

class UploadImage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference images =
      FirebaseFirestore.instance.collection('images');

  Future<void> uploadImage() async {
    String imgName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = storage.ref('images/$imgName');

    try {
      await ref.putFile(MyImageProvider.instance.getImage);
      String downloadURL =
          await storage.ref('images/$imgName').getDownloadURL();
      addImage(downloadURL, ref, imgName);
      MyImageProvider.instance.clearImage();
    } catch (e) {
      print('Error:' + e.toString());
    }
  }

  void addImage(String url, Reference ref, String imgName) async {
    List<String> tagValues = [];
    MyImageProvider.instance.getSelectedTags
        .forEach((tag) => tagValues.add(tag.value));
    try {
      await images.add({
        'time': imgName,
        'tags': tagValues,
        'userID': FirebaseAuth.instance.currentUser.uid,
        'url': url,
        'likes': [],
      });
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }
}
