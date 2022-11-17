import 'package:flutter/material.dart';
import 'package:mind/Models/movie_model.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';

class DummyPage extends StatelessWidget {
  static const routeName = '/dummy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/MovieDescriptionPage',
                arguments: Movie(
                    title: 'title',
                    imageUrl: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
                    video: false,
                    genres: [],
                    watchProviders: [],
                    description: 'description',
                    id: 0,
                    reviews: [],
                    runtime: 0));
          },
        ),
      ),
    );
  }
}
