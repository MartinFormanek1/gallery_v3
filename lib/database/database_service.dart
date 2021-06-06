import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gallery_v3/model/gallery_user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'name': name,
    });
  }

  List<GalleryUser> _userList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return GalleryUser(
        name: doc.data()['name'] ?? '',
      );
    }).toList();
  }

  Stream<List<GalleryUser>> get users {
    return userCollection.snapshots().map(_userList);
  }

  Future<List> getImages(List images) async {
    images = [];
    var result = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .listAll();

    for (var item in result.items) {
      final durl = await item.getDownloadURL();
      images.add(durl);
    }

    return images;
  }

  Future<String> getImageUser(var img) async {
    String imgName = img.toString().substring(84, 119);
    firebase_storage.FullMetadata metadata = await firebase_storage
        .FirebaseStorage.instance
        .ref('images/$imgName')
        .getMetadata();

    return metadata.customMetadata['userId'];
  }
}
