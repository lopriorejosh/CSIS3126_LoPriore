import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Image.asset('lib/Assets/film_strip.jpg'),
        ),
        ListTile(
          onTap: () {},
          title: Text('Home'),
          leading: Icon(Icons.home),
        ),
        Divider(),
        ListTile(
          onTap: () {},
          title: Text('Friends'),
          leading: Icon(Icons.people),
        ),
        Divider(),
        ListTile(
          onTap: () {},
          title: Text('Settings'),
          leading: Icon(Icons.settings),
        ),
        Divider(),
      ],
    ));
  }
}
