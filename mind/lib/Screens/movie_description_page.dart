import 'package:flutter/material.dart';

import '../Widgets/my_appbar.dart';
import '../Models/movie.dart';

class MovieDescriptionPage extends StatelessWidget {
  static const routeName = '/MovieDescriptionPage';

  @override
  Widget build(BuildContext context) {
    var movieInfo = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(movieInfo.imageUrl),
            Center(
              child: Text(movieInfo.title),
            ),
          ],
        ),
      ),
    );
  }
}
