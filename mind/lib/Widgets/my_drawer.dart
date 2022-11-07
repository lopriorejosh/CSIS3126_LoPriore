import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final username = authProv.getAccountInfo(authProv.UID);
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Expanded(child: Image.asset('lib/Assets/launcher_icon.png')),
              Text('Welcome')
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          title: Text('Home'),
          leading: Icon(Icons.home),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/friendsLookup');
          },
          title: Text('Friends'),
          leading: Icon(Icons.people),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/settings');
          },
          title: Text('Settings'),
          leading: Icon(Icons.settings),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.of(context).pushReplacementNamed('/');
          },
          title: Text('Log Out'),
          leading: Icon(Icons.exit_to_app),
        ),
      ],
    ));
  }
}
