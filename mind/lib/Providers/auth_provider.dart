import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Models/http_exception.dart';

import '../API/api_constants.dart';

class AuthProvider with ChangeNotifier {
  late String? _token;
  late DateTime _expiryDate = DateTime.now();
  late String? _UID;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get UID {
    return _UID;
  }

  Future<void> _authenticate(
      String? email, String? password, String endpoint) async {
    final url = Uri.parse(endpoint);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        return Future.error(HttpException(responseData['error']['message']));
      }
      _token = responseData['idToken'];
      _UID = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String? email, String? password) async {
    return _authenticate(email, password, ApiConstants.newUserEndpoint);
  }

  Future<void> signIn(String? email, String? password) async {
    return _authenticate(email, password, ApiConstants.signInUserEndpoint);
  }

  void logout() {
    _token = null;
    _UID = null;
    _expiryDate = DateTime.now();
    print('logout');
  }
}
