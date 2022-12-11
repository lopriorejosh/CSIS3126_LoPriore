import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mind/Models/watch_providers_model.dart';
import 'package:provider/provider.dart';

import '../Widgets/movie_detail_tab.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/my_appbar.dart';
import '../Models/movie_model.dart';
import '../Providers/movies_provider.dart';
import '../Widgets/trailer_window.dart';
import '../Widgets/movie_review_tab.dart';

class DecideMoviePage extends StatefulWidget {
  static const routeName = '/decideMovie';

  @override
  State<DecideMoviePage> createState() => _DecideMoviePageState();
}

class _DecideMoviePageState extends State<DecideMoviePage> {
  @override
  Widget build(BuildContext context) {
    final movieList = ModalRoute.of(context)!.settings.arguments as List<Movie>;
    var movieSelected = Random().nextInt(movieList.length);
    ;

    return Scaffold(
        appBar: MyAppBar(false),
        drawer: MyDrawer(),
        body: Column(children: [
          TrailerWindow(movieList[movieSelected].id),
          DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  movieSelected =
                                      Random().nextInt(movieList.length);
                                  //api error
                                  if (movieSelected == 1049233 ||
                                      movieSelected == 716681950) {
                                    movieSelected =
                                        Random().nextInt(movieList.length);
                                  }
                                });
                              },
                              icon: Icon(Icons.thumb_down)),
                        ),
                        Expanded(
                          child: IconButton(
                              color: Colors.green,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/MovieDescriptionPage',
                                    arguments: movieList[movieSelected]);
                              },
                              icon: Icon(Icons.thumb_up)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.white54,
                      tabs: [
                        Tab(text: 'Details'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .45,
                    child: TabBarView(children: [
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                            future: Provider.of<MoviesProvider>(context,
                                    listen: false)
                                .getMovieDetails(movieList[movieSelected].id),
                            builder: ((context, snapshot) {
                              return snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MovieDetailTab(snapshot.data!);
                            })),
                      ),
                      FutureBuilder(
                          future: Provider.of<MoviesProvider>(context,
                                  listen: false)
                              .getMovieReviews(movieList[movieSelected].id),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Reviews For This Movie',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              );
                            } else {
                              return MovieReviewTab(snapshot.data!);
                            }
                          }))
                    ]),
                  )
                ]),
          )
        ]));
  }
}
