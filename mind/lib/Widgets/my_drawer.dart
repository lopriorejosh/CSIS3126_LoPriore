import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/account_provider.dart';
import '../Providers/movies_provider.dart';
import '../Providers/auth_provider.dart';
import '../Models/movie_model.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountProvider>(context).myAccountInfo;
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Expanded(child: Image.asset('lib/Assets/launcher_icon.png')),
              Text('Welcome ' + accountInfo.username!)
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
          onTap: () async {
            List<Movie> movieList = [];
            await Provider.of<MoviesProvider>(context, listen: false)
                .discoverMovies()
                .then((value) => movieList = value);
            Navigator.of(context)
                .pushReplacementNamed('/decideMovie', arguments: movieList);
          },
          title: Text('Movie Finder'),
          leading: Icon(Icons.movie),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/account');
          },
          title: Text('Account/Friends'),
          leading: Icon(Icons.person),
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
        /*Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/dummy');
          },
          title: Text('Dummy'),
          leading: Icon(Icons.radar),
        ),*/
      ],
    ));
  }
}
