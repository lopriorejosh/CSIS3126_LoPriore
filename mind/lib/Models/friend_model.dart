/*import 'movie_model.dart';

class Friend {
  final String UID;
  final String username;
  final String fname;
  final String lname;
  bool status;

  Friend({
    required this.UID,
    required this.username,
    required this.fname,
    required this.lname,
    required this.status,
  });

//convert json data to friend model
  factory Friend.fromRTDB(Map<String, dynamic> data) {
    return Friend(
        UID: data['UID'],
        username: data['username'],
        fname: data['fname'],
        lname: data['lname'],
        status: data['status'] ?? false);
  }
}
*/