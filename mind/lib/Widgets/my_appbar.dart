import 'package:flutter/material.dart';
import 'package:mind/Providers/movies_provider.dart';

import '../Models/movie_model.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
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
                //navigate to profile page
              },
              icon: Icon(Icons.person)),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}
