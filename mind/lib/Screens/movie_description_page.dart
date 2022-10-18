import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

import '../Widgets/my_appbar.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              child: Image.network(
                ApiConstants.imageEndpoint +
                    ApiConstants.originalImageEndpoint +
                    movieInfo.backdropPath,
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Text(
                movieInfo.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpandableText(
                movieInfo.overview,
                expandText: 'Show More',
                collapseText: 'Show Less',
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
