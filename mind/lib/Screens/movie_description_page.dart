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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Stack(children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  width: double.infinity,
                  child: Image.network(
                    ApiConstants.imageEndpoint +
                        ApiConstants.originalImageEndpoint +
                        movieInfo.backdropPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    textAlign: TextAlign.center,
                    movieInfo.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ]),
            ElevatedButton(
              child: Text(
                'Watch Trailer',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              onPressed: () {
                print(movieInfo.genreIds[0]);
              },
            ),
            const Divider(),
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
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Genres: ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            //get genres here
            Row(
              children: [],
            ),
            Spacer(),
            //add where to watch
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available to Watch On: ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
