import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mind/Models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/friend_model.dart';
import '../Providers/auth_provider.dart';

class AccountProvider extends ChangeNotifier {
  final _db = FirebaseDatabase.instance.ref();
  final _storage = FirebaseStorage.instance;

  User myAccount =
      User(username: '', email: '', password: '', UID: '', profilePic: null);

  User get myAccountInfo => myAccount;

  List<Friend> _friends = [];
  List<Friend> get friendsList => _friends;

  late StreamSubscription<DatabaseEvent> _accountStream;
  late StreamSubscription<DatabaseEvent> _friendsStream;

  //set up account info stream when initialized
  void fetchAccountInfo(BuildContext context) {
    var accountFinder = Provider.of<AuthProvider>(context, listen: false);
    _accountStream =
        _db.child('users/${accountFinder.UID}').onValue.listen((event) {
      final fetchedAccount = event.snapshot.value as Map<dynamic, dynamic>;

      print(fetchedAccount.values);

      //myAccount = User.fromRTDB(fetchedAccount.values as Map<dynamic, dynamic>);
    });

    print(myAccount.username);
  }

//set up stream and update the friends list whenever new events come in
  void fetchFriends(BuildContext context) {
    var account = Provider.of<AuthProvider>(context, listen: false);

    _friendsStream =
        //listen to db stream
        _db.child('users/${account.UID}/friends').onValue.listen(
      (event) {
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
      },
      onError: (error) {
        print(error);
      },
      onDone: () => print('done'),
    );
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
    _friendsStream
        .cancel(); //stop listening on the stream if provider is deleted
  }
}
