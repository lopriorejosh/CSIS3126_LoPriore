import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/account_provider.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/my_drawer.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: accountInfo.profPicUrl == null
                      ? Placeholder()
                      : Image.network(accountInfo.profPicUrl!)),
            ),
            Text("Account Info: "),
            Text(accountInfo.username!),
            Text(accountInfo.email!),
          ],
        ),
      ),
    );
  }
}
