import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/search_delegates.dart';
import '../Providers/account_provider.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/my_friends_list.dart';

class FriendsLookupPage extends StatefulWidget {
  static const routeName = '/friendsLookup';

  @override
  State<FriendsLookupPage> createState() => _FriendsLookupPageState();
}

class _FriendsLookupPageState extends State<FriendsLookupPage> {
  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).fetchFriends(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var friends = Provider.of<AccountProvider>(context).friendsList;

    return Scaffold(
      appBar: MyAppBar(false),
      drawer: MyDrawer(),
      body: MyFriendsList(),
      floatingActionButton: friends.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: Icon(Icons.add),
              onPressed: () {
                showSearch(context: context, delegate: FriendSearchDelegate());
              },
            ),
    );
  }
}
