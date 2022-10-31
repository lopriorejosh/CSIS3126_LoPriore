import 'package:flutter/material.dart';

import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Text('settings page'),
      ),
    );
  }
}
