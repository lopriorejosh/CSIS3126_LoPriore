import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/http_exception.dart';
import '../API/api_constants.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate = DateTime.now();
  String? _UID;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
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
      _autoLogout();
      notifyListeners();
      //used to store sign in data on the device for auto sign in
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'UID': _UID,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String? email, String? password) async {
    return _authenticate(email, password, ApiConstants.newUserEndpoint);
    //addUsersToDatabase();
  }

  Future<void> signIn(String? email, String? password) async {
    return _authenticate(email, password, ApiConstants.signInUserEndpoint);
  }

  Future<void> logout() async {
    _token = null;
    _UID = null;
    _expiryDate = DateTime.now();
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //clear prefs from device to prevent infinite loop
    prefs.clear();
  }

  void _autoLogout() {
    //if there is a timer stop ticking. logs out based on expired datetime
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _UID = extractedUserData['UID'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> addUsersToDatabase() async {
    final url = Uri.parse(
        "${ApiConstants.fireBaseDatabaseUrl}${ApiConstants.dataBaseUsers}/$UID.json");
    try {
      print('send user');
      final response = await http.post(url,
          body: json.encode(
            {'UID': _UID},
          ));
      print(response.body);
    } catch (error) {
      rethrow;
    }
  }
}
