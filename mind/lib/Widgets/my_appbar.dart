import 'package:flutter/material.dart';

import '../Widgets/search_delegates.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool haveSearch;

  MyAppBar(this.haveSearch);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: Text(
          'Mind',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: !haveSearch
            ? null
            : [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MovieSearchDelegate());
                    },
                    icon: const Icon(Icons.search)),
              ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}
