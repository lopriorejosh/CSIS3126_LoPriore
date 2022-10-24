import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';

class AuthProvider with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _UID;

  Future<void> signup(String? username, String? password) async {
    final newUserEndpoint = Uri.parse(ApiConstants.newUserEndpoint);
//add error handling
    var response = await http.post(newUserEndpoint,
        body: json.encode({'email': username, 'password': password}));

    log(response.body);
  }

  Future<void> signIn(String? username, String? password) async {
    final signInEndpoint = Uri.parse(ApiConstants.signInUserEndpoint);
//add error handling
    var response = await http
        .post(signInEndpoint, body: {'email': username, 'password': password});
    log(response.body);
  }
}
