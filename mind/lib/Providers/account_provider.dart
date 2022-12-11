import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/user_model.dart';
import '../Models/genre_model.dart';
import '../Providers/auth_provider.dart';

class AccountProvider extends ChangeNotifier {
  final _db = FirebaseDatabase.instance.ref();
  final _storage = FirebaseStorage.instance;

  User myAccount = User(
      username: '',
      email: '',
      password: '',
      UID: '',
      profilePic: null,
      profPicUrl: '');

  User get myAccountInfo => myAccount;

  List<User> _friends = [];
  List<User> get friendsList => _friends;

  //late StreamSubscription<DatabaseEvent> _accountStream;
  late StreamSubscription<DatabaseEvent> _friendsStream;
  //late StreamSubscription<DatabaseEvent> _movieStream;

  Future<void> getProfPic(BuildContext context) async {
    var accountFinder = Provider.of<AuthProvider>(context, listen: false);

    myAccount.profPicUrl = await _storage
        .ref()
        .child('/usersProfilePictures/${accountFinder.UID}.jpg')
        .getDownloadURL();
  }

  //set up account info stream when initialized
  void fetchAccountInfo(BuildContext context) {
    var accountFinder = Provider.of<AuthProvider>(context, listen: false);
    myAccount.UID = accountFinder.UID;
    getProfPic(context);
    _db.child('users/${accountFinder.UID}').onValue.listen((event) {
      final fetchedAccount = event.snapshot.value as Map<dynamic, dynamic>;
      //convert snapshot to user model
      final convertedInfo = User.fromJsonToUser(fetchedAccount);
      //set provider account to use everywhere
      myAccount.username = convertedInfo.username;
      myAccount.email = convertedInfo.email;
    });
  }

//set up stream and update the friends list whenever new events come in
  void fetchFriends(BuildContext context) {
    var account = Provider.of<AuthProvider>(context, listen: false);

    _friendsStream =
        //listen to db stream
        _db.child('users/${account.UID}/friends').onValue.listen(
      (event) {
        if (event.snapshot.value == null) {
          return;
        }
        //set as map to convert
        final allFriends = event.snapshot.value as Map<dynamic, dynamic>;
        //set list to values
        _friends = allFriends.values
            .map(
              (friendAsJson) =>
                  User.fromJsonToUser(Map<String, dynamic>.from(friendAsJson)),
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

  Future<void> addFriend(User friendToAdd, BuildContext context) async {
    var account = Provider.of<AuthProvider>(context, listen: false);
    DatabaseReference friendsListRef =
        FirebaseDatabase.instance.ref('users/${account.UID}/friends');
    DatabaseReference newFriend = friendsListRef.push();
    try {
      await newFriend.set({
        'UID': friendToAdd.UID,
        'username': friendToAdd.username,
        'fname': friendToAdd.fname,
        'lname': friendToAdd.lname,
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> setGenresToSearch(
      List<Genre> genresToSearch, BuildContext context) async {
    var account = Provider.of<AuthProvider>(context, listen: false);
    DatabaseReference _connectedWith =
        FirebaseDatabase.instance.ref('users/${account.UID}/connectedWith');
    DatabaseReference setGenres = _connectedWith.push();
    try {
      await setGenres.set({'genre': genresToSearch[0].name});
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
