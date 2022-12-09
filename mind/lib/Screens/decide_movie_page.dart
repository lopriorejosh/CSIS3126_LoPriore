import 'package:flutter/material.dart';

class DecideMoviePage extends StatelessWidget {
  static const routeName = '/decideMovie';

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
        child: Text('decide page'),
      ),
    );
  }
}
