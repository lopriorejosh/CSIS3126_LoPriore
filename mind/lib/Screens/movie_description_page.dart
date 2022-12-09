import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:mind/Models/video_model.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Widgets/my_appbar.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';

class MovieDescriptionPage extends StatefulWidget {
  static const routeName = '/MovieDescriptionPage';

  @override
  State<MovieDescriptionPage> createState() => _MovieDescriptionPageState();
}

//TODO: CREATE STATEFUL WIDGETS TO DISPLAY GENRES AND WATCH PROVIDERS. STATEFUL TO CALL SETSTATE WITH API CALL

class _MovieDescriptionPageState extends State<MovieDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    var movieInfo = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(true),
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
                        movieInfo.poster_path.toString(),
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
                Navigator.of(context)
                    .pushNamed('/youtubePlayer', arguments: movieInfo.id);
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpandableText(
                movieInfo.overview.toString(),
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
            Expanded(
              child: FutureBuilder(
                future: Provider.of<MoviesProvider>(context)
                    .getSingleMovieGenre(movieInfo.id),
                builder: ((context, snapshot) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * .3,
                        child: Card(
                            elevation: 8,
                            color: Colors.green,
                            child: Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].name.toString()))),
                      );
                    }))),
              ),
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
            Expanded(
              child: FutureBuilder(
                future: Provider.of<MoviesProvider>(context)
                    .getSingleMovieWP(movieInfo.id),
                builder: ((context, snapshot) => snapshot.data?.length == 0
                    ? Center(
                        child: Text('No Streaming Options'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: ((context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width * .2,
                            child: Card(
                                elevation: 8,
                                color: Colors.green,
                                child: Center(
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        snapshot.data![index].providerName
                                            .toString()))),
                          );
                        }))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
