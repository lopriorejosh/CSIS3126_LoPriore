import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/account_provider.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_friends_list.dart';
import '../Widgets/search_delegates.dart';

class AccountPage extends StatefulWidget {
  static const routeName = "/account";

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final accountInfo =
        Provider.of<AccountProvider>(context, listen: false).myAccount;
    return Scaffold(
      appBar: MyAppBar(false),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            //account info
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(accountInfo.profPicUrl!),
                radius: 50,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome ' + accountInfo.username!,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                accountInfo.email!,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Divider(),
            //friends list
            SizedBox(
                height: MediaQuery.of(context).size.height * .55,
                child: MyFriendsList()),
            Divider(),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  showSearch(
                      context: context, delegate: FriendSearchDelegate());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
