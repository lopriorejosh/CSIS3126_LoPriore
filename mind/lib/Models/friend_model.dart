import 'movie_model.dart';

class Friend {
  final String UID;
  final String username;
  bool status;

  Friend({
    required this.UID,
    required this.username,
    required this.status,
  });

//convert json data to friend model
  factory Friend.fromRTDB(Map<String, dynamic> data) {
    return Friend(
        UID: data['UID'],
        username: data['username'],
        status: data['status'] ?? false);
  }
}
