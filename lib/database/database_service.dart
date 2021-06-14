import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference images =
      FirebaseFirestore.instance.collection('images');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  String currentUser = FirebaseAuth.instance.currentUser.uid.trim() ?? '';

  List<Map<String, dynamic>> _data;
  Map<String, bool> imgData = Map();

  Future initData() async {
    _data = await fetchImages();
  }

  void addLike(String poster, String url) async {
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
    List<List<String>> likes = [];
    QuerySnapshot snapshot =
        await images.orderBy('time', descending: true).get();

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

  Future<List<bool>> isForeignLikedByCurrentUser(List<String> urls) async {
    List<List<String>> likes = [];
    QuerySnapshot snapshot =
        await images.orderBy('time', descending: true).get();

    var data = [];
    snapshot.docs.forEach((element) {
      data.add(element.data());
    });

    var filteredData = [];
    for (var doc in data) {
      urls.forEach((element) {
        if (doc['url'] == element) {
          filteredData.add(doc);
        }
      });
    }

    filteredData.forEach((element) {
      List<dynamic> docData = element['likes'];
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
    QuerySnapshot snapshot =
        await images.orderBy('time', descending: true).get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  Future<List<String>> getFilteredUrls() async {
    QuerySnapshot snapshot = await images
        .where('userID', isEqualTo: currentUser)
        .orderBy('time', descending: true)
        .get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data()).toList();

    List<String> urls = [];
    if (data != null) {
      if (data.isNotEmpty) {
        data.forEach((doc) {
          urls.add(doc['url']);
        });
      }
    }
    return urls;
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

  Future<List<String>> getUsernames() async {
    QuerySnapshot snapshot = await users.get();
    var userData = snapshot.docs.map((doc) => doc.data()).toList();

    List<String> usernames = [];
    userData.forEach((user) => usernames.add(user['username']));

    return usernames;
  }

  Future<String> getUsername() async {
    DocumentSnapshot snapshot = await users.doc(currentUser).get();
    var username = snapshot.data()['username'];
    return username;
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

  Future<List<String>> getForeignUrls(String username) async {
    String userID = '';

    QuerySnapshot userSnapshot =
        await users.where('username', isEqualTo: username).get();

    userSnapshot.docs.forEach((element) {
      userID = element.id;
    });

    QuerySnapshot snapshot = await images
        .where('userID', isEqualTo: userID)
        .orderBy('time', descending: true)
        .get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data()).toList();

    List<String> urls = [];
    if (data != null) {
      if (data.isNotEmpty) {
        data.forEach((doc) {
          urls.add(doc['url']);
        });
      }
    }
    return urls;
  }

  void addFollow(String poster) async {
    String userID = '';
    QuerySnapshot snapshot =
        await users.where('username', isEqualTo: poster).get();

    snapshot.docs.forEach((element) {
      userID = element.id;
    });

    DocumentSnapshot userDoc = await users.doc(currentUser).get();

    List<String> follows = [];
    for (var follow in userDoc['follows']) {
      follows.add(follow);
    }

    bool removed = false;

    for (String follow in follows) {
      if (follow == userID) {
        follows.remove(follow);
        removed = true;
        break;
      }
    }
    if (!removed) {
      follows.add(userID);
    }

    users.doc(currentUser).update({'follows': follows});
  }

  void addSaved(String imageUrl) async {
    DocumentSnapshot userDoc = await users.doc(currentUser).get();

    List<String> saved = [];
    for (var save in userDoc['saved']) {
      saved.add(save);
    }

    bool removed = false;

    for (String save in saved) {
      if (save == imageUrl) {
        saved.remove(save);
        removed = true;
        break;
      }
    }
    if (!removed) {
      saved.add(imageUrl);
    }

    print('kek');

    users.doc(currentUser).update({'saved': saved});
  }

  Future<List<String>> getGalleryUrls() async {
    DocumentSnapshot snapshot = await users.doc(currentUser).get();

    var data = snapshot.data()['saved'];

    List<String> urls = [];
    if (data != null) {
      for (var url in data) {
        urls.add(url.toString());
      }
    }

    return urls;
  }

  Future<List<String>> getFollowUrls() async {
    DocumentSnapshot userSnapshot = await users.doc(currentUser).get();
    QuerySnapshot imgSnapshot =
        await images.orderBy('time', descending: true).get();

    var userData = userSnapshot['follows'];

    List<String> userFollows = [];
    if (userData != null) {
      for (var follow in userData) {
        userFollows.add(follow.toString());
      }
    }

    var imgData = [];
    if (imgSnapshot != null) {
      for (var doc in imgSnapshot.docs) {
        imgData.add(doc.data());
      }
    }

    List<String> urls = [];

    urls = imgData
        .where((element) => userFollows.contains(element['userID']))
        .map((e) => e['url'].toString())
        .toList();

    return urls;
  }
}
