import 'package:flutter/material.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/searchMovie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Mind',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Search page'),
      ),
    );
  }
}
