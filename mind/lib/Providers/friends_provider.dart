import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Models/friend_model.dart';

class FriendsProvider extends ChangeNotifier {
  late final List<Friend> _friends = [
    Friend('plaj5oFbY5drNw35okMjivCTEUT2', 'Josh L.', false),
    Friend('plaj5oFbY5drNw35okMjivCTEUT2', 'Tyer C.', true),
    Friend('plaj5oFbY5drNw35okMjivCTEUT2', 'Nick W.', false)
  ];

  List<Friend> get friendsList => _friends;

  //add network request for friend information, dummy info atm
}
