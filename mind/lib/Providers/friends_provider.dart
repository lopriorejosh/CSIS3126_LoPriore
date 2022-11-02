import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/friend_model.dart';
import '../Providers/auth_provider.dart';

class FriendsProvider extends ChangeNotifier {
  late List<Friend> _friends = [];

  List<Friend> get friendsList => _friends;

  //add network request for friend information, dummy info atm

  Future<void> searchFriend() async {}

  Future<void> fetchFriends(BuildContext context) async {
    var account = Provider.of<AuthProvider>(context, listen: false);
    var url = Uri.parse(
        ApiConstants.dataBaseUsers + 'users/${account.UID}/friends.json');
    try {
      var response = await http.get(url);
      print(response.body);
      List<Friend> _fetchedFriends = json.decode(response.body).results;
      _friends = _fetchedFriends;
      print(_fetchedFriends[0]);
    } catch (error) {}
  }

  Future<void> addFriend(String? username, BuildContext context) async {
    var account = Provider.of<AuthProvider>(context, listen: false);
    var addUrl = Uri.parse(ApiConstants.fireBaseDatabaseUrl +
        '/users/${account.UID}/friends.json');
    try {
      var response =
          await http.post(addUrl, body: json.encode({'username': username}));
      print(response.body);
    } catch (error) {}
  }
}
