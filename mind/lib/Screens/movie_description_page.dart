import 'package:flutter/material.dart';
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
          mainAxisSize: MainAxisSize.max,
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
                  height: MediaQuery.of(context).size.height * .5,
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                children: [
                  Center(
                    child: FittedBox(
                        child: Text(
                      movieInfo.tagline!.isNotEmpty
                          ? movieInfo.tagline.toString()
                          : 'No Tagline',
                      style: Theme.of(context).textTheme.caption,
                    )),
                  ),
                  Divider(),
                  Center(
                    child: FittedBox(
                      child: Text(
                        'Overview',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movieInfo.overview.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                    width: double.infinity,
                    child: FutureBuilder(
                      future: Provider.of<MoviesProvider>(context)
                          .getSingleMovieWP(movieInfo.id),
                      builder: ((context, snapshot) => snapshot.data?.length ==
                              0
                          ? Center(
                              child: Text(
                                'No Streaming Options',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: ((context, index) {
                                return SizedBox(
                                  //height: 75,
                                  width: 100,
                                  child: Card(
                                      elevation: 8,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          snapshot.data![index].providerName
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      )),
                                );
                              }))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      child: Text(
                        'Runtime: ' + movieInfo.runtime.toString() + ' min.',
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
                  SizedBox(
                      height: 50,
                      child: Text(
                        'Release Date: ' + movieInfo.release_date.toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
                  SizedBox(
                      height: 50,
                      child: Text(
                        'Popularity: ' +
                            movieInfo.runtime.toString() +
                            ' rating',
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
                ],
              ),
            ),
/*
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  movieInfo.overview.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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
                    shrinkWrap: true,
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
                        shrinkWrap: true,
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
            )*/
          ],
        ),
      ),
    );
  }
}
