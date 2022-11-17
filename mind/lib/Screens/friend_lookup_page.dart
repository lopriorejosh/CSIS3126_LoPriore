import 'package:flutter/material.dart';
import 'package:mind/Widgets/search_delegates.dart';
import 'package:provider/provider.dart';

import '../Providers/account_provider.dart';
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
    Provider.of<AccountProvider>(context, listen: false).fetchFriends(context);
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
    var friends = Provider.of<AccountProvider>(context).friendsList;

    return friends.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/Assets/friends stock.jpg'),
              FittedBox(
                child: Text(
                  "Empty Friends List... Add Some Friends",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Divider(),
              ElevatedButton(
                  onPressed: () {
                    //search for friend
                    showSearch(
                        context: context, delegate: FriendSearchDelegate());
                  },
                  child: Text("Add Friends",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge)),
            ],
          )
        : ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.person),
                  title: Text(friends[index].username),
                ));
  }
}
