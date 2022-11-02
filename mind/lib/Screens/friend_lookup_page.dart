import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/friends_provider.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';

class FriendsLookupPage extends StatefulWidget {
  static const routeName = '/friendsLookup';

  @override
  State<FriendsLookupPage> createState() => _FriendsLookupPageState();
}

class _FriendsLookupPageState extends State<FriendsLookupPage> {
  @override
  void initState() {
    Provider.of<FriendsProvider>(context, listen: false).fetchFriends(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
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
