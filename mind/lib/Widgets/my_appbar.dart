import 'package:flutter/material.dart';

import '../Providers/movies_provider.dart';
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
                //navigate to search page
              },
              icon: const Icon(Icons.search)),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}
