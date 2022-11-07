import 'package:flutter/material.dart';
import 'package:mind/Models/friend_model.dart';
import 'package:provider/provider.dart';

import '../Providers/friends_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FriendsProvider>(context);

    return AppBar(
        elevation: 0,
        title: Text(
          'Mind',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //navigate to search page
                provider.addFriend(
                    Friend(
                        UID: 'dsfdsfsdfxzxdas',
                        username: 'jlopriore',
                        status: true),
                    context);
              },
              icon: const Icon(Icons.search)),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}
