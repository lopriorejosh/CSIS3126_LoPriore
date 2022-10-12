import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/friend_model.dart';

class FriendsProvider extends ChangeNotifier {
  late List<Friend> _friends = [
    Friend('Test1User'),
    Friend('Test 2 User'),
    Friend('Test 3 User'),
  ];

  List<Friend> get friendsList => _friends;

  //add network request for friend information, dummy info atm
}
