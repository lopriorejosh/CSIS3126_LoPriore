import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(
                  'Your Friends',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                              ),
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  friends[index].username.toString(),
                                ),
                                subtitle: Text(friends[index].fname.toString() +
                                    ' ' +
                                    friends[index].lname.toString()),
                                trailing: IconButton(
                                  icon: Icon(
                                      Icons.connect_without_contact_rounded),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/connect',
                                        arguments: friends[index]);
                                  },
                                ),
                              ),
                            ),
                          )),
                )
              ]);
  }
}
