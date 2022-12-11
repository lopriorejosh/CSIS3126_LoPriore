import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/http_exception.dart';
import '../Models/user_model.dart';
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

  Future<void> signup(User newUser) async {
    final url = Uri.parse(ApiConstants.newUserEndpoint);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': newUser.email,
            'password': newUser.password,
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
      //if signing up
      await addUsersToDatabase(newUser);

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

  Future<void> signIn(User user) async {
    final url = Uri.parse(ApiConstants.signInUserEndpoint);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': user.email,
            'password': user.password,
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

//when an account is created set user in database
  Future<void> addUsersToDatabase(User newUser) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('/users/$UID');
    final storage = FirebaseStorage.instance
        .ref()
        .child('usersProfilePictures/$UID' + '.jpg');

    await ref.set({
      "email": newUser.email,
      "username": newUser.username,
      'fname': newUser.fname,
      'lname': newUser.lname
    });
    await storage.putFile(newUser.profilePic!);
  }
}
