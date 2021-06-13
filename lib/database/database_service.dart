import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference images =
      FirebaseFirestore.instance.collection('images');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  List<Map<String, dynamic>> _data;
  Map<String, bool> imgData = Map();

  Future initData() async {
    _data = await fetchImages();
    //fillImgData();
  }

  void fillImgData() async {
    List<String> urls = [];
    urls = fetchField('url');

    List<bool> liked = [];
    //urls = getLikesFromPoster();
  }

  void addLike(String poster, String url) async {
    String currentUser = FirebaseAuth.instance.currentUser.uid.trim();
    String uID = await getUID(poster);

    QuerySnapshot snapshot = await images.where('url', isEqualTo: url).get();
    String imageID = '';
    snapshot.docs.forEach((element) => imageID = element.id);

    List<String> likes = [];
    DocumentSnapshot likeSnapshot = await images.doc(imageID).get();
    List<dynamic> docData = likeSnapshot.get('likes');
    docData.forEach((element) {
      likes.add(element.toString());
    });

    bool removed = false;
    if (likes != null) {
      if (likes.isNotEmpty) {
        for (var user in likes) {
          if (user.contains(currentUser)) {
            likes.remove(user);
            removed = true;
            break;
          }
        }
      }
    }

    if (!removed) {
      likes.add(currentUser);
    }

    await images.doc(imageID).update({'likes': likes});
  }

  Future<List<bool>> isLikedByCurrentUser() async {
    String currentUser = '';
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = FirebaseAuth.instance.currentUser.uid.trim();
    }

    List<List<String>> likes = [];
    QuerySnapshot snapshot = await images.get();

    snapshot.docs.forEach((element) {
      List<dynamic> docData = element.get('likes');
      List<String> like = [];
      for (var value in docData) {
        like.add(value.toString());
      }
      likes.add(like);
    });

    List<bool> contains = [];

    for (var like in likes) {
      contains.add(_isLiked(currentUser, like));
    }

    return contains;
  }

  bool _isLiked(String currentUser, List<String> like) {
    for (var value in like) {
      if (value.contains(currentUser)) {
        return true;
      }
    }
    return false;
  }

  Future<String> getUID(String username) async {
    QuerySnapshot snapshot =
        await users.where('username', isEqualTo: username).get();

    String uID = '';
    snapshot.docs.forEach((element) => uID = element['uID']);

    return uID;
  }

  Future fetchImages() async {
    QuerySnapshot snapshot = await images.get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  List<String> getUrls() {
    List<String> urls = [];
    urls = fetchField('url');
    return urls;
  }

  Future<List<String>> getImagePoster() async {
    List<String> userIDS = [];
    userIDS = fetchField('userID');

    List<String> usernames = [];

    for (var uID in userIDS) {
      DocumentSnapshot snapshot = await users.doc(uID).get();
      usernames.add(snapshot.data()['username']);
    }

    return usernames;
  }

  Future<List<String>> getUsername() async {
    QuerySnapshot snapshot = await users.get();
    var userData = snapshot.docs.map((doc) => doc.data()).toList();

    List<String> usernames = [];
    userData.forEach((user) => usernames.add(user['username']));

    // usernames = hope hopes kek

    return usernames;
  }

  List<String> fetchField(String field) {
    List<String> fieldData = [];
    if (_data != null) {
      if (_data.isNotEmpty) {
        _data.forEach((doc) {
          fieldData.add(doc[field]);
        });
      }
    }
    return fieldData;
  }
}

/*Future<bool> getLikes(String poster, String url) async {
    String currentUser = FirebaseAuth.instance.currentUser.uid.trim();

    QuerySnapshot snapshot = await images.where('url', isEqualTo: url).get();
    String imageID = '';
    snapshot.docs.forEach((element) => imageID = element.id);

    List<String> likes = [];
    DocumentSnapshot likeSnapshot = await images.doc(imageID).get();
    List<dynamic> docData = likeSnapshot.get('likes');
    docData.forEach((element) {
      likes.add(element.toString());
    });

    if (likes != null) {
      if (likes.isNotEmpty) {
        for (var user in likes) {
          if (user.contains(currentUser)) {
            print('yes');
            return true;
          }
        }
      }
    }

    print('no');
    return false;

QuerySnapshot likeSnapshot =
    await images.doc(imageID).collection('likes').get();

    Map<String, String> likeDocs = Map();
    likeSnapshot.docs.forEach((element) {
      likeDocs.addAll({element.id: element.data()['uID']});
    });

    List<String> likeDocsValues = [];
    likeDocsValues = likeDocs.values.toList();

    for (var doc in likeDocsValues) {
      if (doc == currentUser) {
        return true;
      }
    }
    return false;
}

void getLikesFromPoster() async {
    String currentUser = FirebaseAuth.instance.currentUser.uid.trim();

    QuerySnapshot snapshot = await images.get();

    List<String> imgIDS = [];
    snapshot.docs.forEach((element) => imgIDS.add(element.id));

    Map<String, String> likeDocs = Map();
    List<bool> currentUserLiked = [];

    for (var img in imgIDS) {
      QuerySnapshot likeSnapshot =
          await images.doc(img).collection('likes').get();

      likeSnapshot.docs.forEach((element) {
        if (element.id != 'fill') {
          likeDocs.addAll({element.id: element.data()['uID']});
        } else {
          likeDocs.addAll({'fill': 'fill'});
        }
      });
    }

    List<String> likeDocsValues = [];
    likeDocsValues = likeDocs.values.toList();

    for (var doc in likeDocsValues) {
      if (doc == currentUser) {
        currentUserLiked.add(true);
      } else {
        currentUserLiked.add(false);
      }
    }

    print(currentUserLiked);
    print(currentUser);
    print(currentUserLiked);

    QuerySnapshot likeSnapshot =
        await images.doc(imageID).collection('likes').get();

    Map<String, String> likeDocs = Map();
    likeSnapshot.docs.forEach((element) {
      likeDocs.addAll({element.id: element.data()['uID']});
    });

    List<String> likeDocsValues = [];
    likeDocsValues = likeDocs.values.toList();

    for (var doc in likeDocsValues) {
      if (doc == currentUser) {
        return true;
      }
    }
    return false;
  }

  Future<bool> getLikes(String poster, String url) async {
    String currentUser = FirebaseAuth.instance.currentUser.uid.trim();

    QuerySnapshot snapshot = await images.where('url', isEqualTo: url).get();
    String imageID = '';
    snapshot.docs.forEach((element) => imageID = element.id);

    QuerySnapshot likeSnapshot =
        await images.doc(imageID).collection('likes').get();

    Map<String, String> likeDocs = Map();
    likeSnapshot.docs.forEach((element) {
      likeDocs.addAll({element.id: element.data()['uID']});
    });

    List<String> likeDocsValues = [];
    likeDocsValues = likeDocs.values.toList();

    for (var doc in likeDocsValues) {
      if (doc == currentUser) {
        return true;
      }
    }
    return false;
  }*/
