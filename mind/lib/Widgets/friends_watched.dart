import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/friend_model.dart';
import '../Models/movie_model.dart';

class FriendsWatched extends StatelessWidget {
  //dummy friends

  List<Friend> friends = [
    Friend('spookyoofs', []),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      width: double.infinity,
      child: Column(children: []),
    );
  }
}
