import 'dart:io';

class User {
  String? username;
  String? email;
  String? password;
  String? fname;
  String? lname;
  String? UID;
  File? profilePic;
  String? profPicUrl;

  User(
      {this.username,
      this.email,
      this.password,
      this.fname,
      this.lname,
      this.UID,
      this.profilePic,
      this.profPicUrl});

  //convert json data to friend model
  factory User.fromJsonToUser(Map<dynamic, dynamic> data) {
    return User(
        username: data['username'],
        email: data['email'],
        fname: data['fname'],
        lname: data['lname'],
        UID: data['UID']);
  }
}
