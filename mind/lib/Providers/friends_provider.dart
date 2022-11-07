import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Models/friend_model.dart';
import '../Providers/auth_provider.dart';

class FriendsProvider extends ChangeNotifier {
  final _db = FirebaseDatabase.instance.ref();
  List<Friend> _friends = [];

  late StreamSubscription<DatabaseEvent> _friendsStream;

  List<Friend> get friendsList => _friends;

  void fetchFriends(BuildContext context) {
    var account = Provider.of<AuthProvider>(context, listen: false);

    _friendsStream =
        //listen to db stream
        _db.child('users/${account.UID}/friends').onValue.listen((event) {
      //set as map to convert
      final allFriends = event.snapshot.value as Map<dynamic, dynamic>;
      //set list to values
      _friends = allFriends.values
          .map(
            (friendAsJson) =>
                Friend.fromRTDB(Map<String, dynamic>.from(friendAsJson)),
          )
          .toList();
      notifyListeners();
    });
  }

  Future<void> addFriend(Friend friendToAdd, BuildContext context) async {
    var account = Provider.of<AuthProvider>(context, listen: false);
    DatabaseReference friendsListRef =
        FirebaseDatabase.instance.ref('users/${account.UID}/friends');
    DatabaseReference newFriend = friendsListRef.push();
    try {
      await newFriend.set({
        'UID': friendToAdd.UID,
        'username': friendToAdd.username,
        'Status': friendToAdd.status
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _friendsStream.cancel(); //stop listening on the stream
  }
}
