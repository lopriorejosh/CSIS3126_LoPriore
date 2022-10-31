import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/my_appbar.dart';
import '../Providers/friends_provider.dart';

class FriendsLookupPage extends StatelessWidget {
  static const routeName = '/friendsLookup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: MyFriendsList(),
    );
  }
}

class MyFriendsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var friends = Provider.of<FriendsProvider>(context).friendsList;

    return ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.person),
              title: Text(friends[index].username),
            ));
  }
}
