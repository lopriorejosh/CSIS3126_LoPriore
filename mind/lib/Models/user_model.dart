import 'dart:io';

class User {
  String? username;
  String? email;
  String? password;
  String? UID;
  File? profilePic;
  String? profPicUrl;

  User(
      {this.username,
      this.email,
      this.password,
      this.UID,
      this.profilePic,
      this.profPicUrl});

  //convert json data to friend model
  factory User.fromRTDB(Map<dynamic, dynamic> data) {
    return User(username: data['username'], email: data['email']);
  }
}
