import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchService {
  final CollectionReference _images =
      FirebaseFirestore.instance.collection('images');

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<List<String>> searchUsers(String query) async {
    List<String> users = [];
    List<String> orgUsers = [];
    QuerySnapshot snapshot = await _users.get();
    snapshot.docs.forEach((doc) {
      users.add(doc.data()['username'].toString().toLowerCase());
      orgUsers.add(doc.data()['username']);
    });

    List<String> filteredUsers = [];
    for (int i = 0; i < users.length; i++) {
      if (users[i].contains(query ?? '')) {
        filteredUsers.add(orgUsers[i]);
      }
    }

    return query == '' ? orgUsers : filteredUsers;
  }

  Future<List<String>> getImages(List<String> _tags) async {
    QuerySnapshot snapshot =
        await _images.orderBy('time', descending: true).get();

    var data = [];
    snapshot.docs.forEach((element) {
      data.add(element.data());
    });

    var _filteredData = data
        .where((doc) => _tags.every((element) => doc['tags'].contains(element)))
        .map((e) => e['url'].toString())
        .toList();

    return _filteredData;
  }

  Future<List<bool>> isLikedByCurrentUser(List<String> _urls) async {
    String currentUser = '';
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = FirebaseAuth.instance.currentUser.uid.trim();
    }

    List<List<String>> likes = [];
    QuerySnapshot snapshot =
        await _images.orderBy('time', descending: true).get();

    var data = [];
    snapshot.docs.forEach((element) {
      data.add(element.data());
    });

    var filteredData = [];
    for (var doc in data) {
      _urls.forEach((element) {
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

  getImagePoster(List<String> _urls) async {
    List<String> userIDS = [];

    QuerySnapshot snapshot =
        await _images.orderBy('time', descending: true).get();

    var data = [];
    snapshot.docs.forEach((element) {
      data.add(element.data());
    });

    var allUrls = [];
    data.forEach((element) {
      allUrls.add(element['url']);
    });

    var filteredUrl = [];
    for (String url in _urls) {
      for (String aUrl in allUrls) {
        if (url == aUrl) {
          filteredUrl.add(aUrl);
        }
      }
    }

    for (var doc in data) {
      for (var url in filteredUrl) {
        if (doc['url'] == url) {
          userIDS.add(doc['userID']);
        }
      }
    }

    List<String> usernames = [];
    for (String uID in userIDS) {
      DocumentSnapshot snapshot = await _users.doc(uID).get();
      usernames.add(snapshot.data()['username']);
    }

    return usernames;
  }
}
