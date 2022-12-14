import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Providers/account_provider.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/top_movie.dart';
import '../Widgets/row_of_movies.dart';
import '../Widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  var pageController = PageController();

  @override
  void initState() {
    //initial pull of data before build
    Provider.of<MoviesProvider>(context, listen: false)
        .fetchMovieList('popular');
    Provider.of<MoviesProvider>(context, listen: false)
        .fetchMovieList('topRated');
    Provider.of<AccountProvider>(context, listen: false)
        .fetchAccountInfo(context);
    Provider.of<AccountProvider>(context, listen: false).fetchFriends(context);
    super.initState();
    //pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    var popularMovies = Provider.of<MoviesProvider>(context).popularMovies;
    var topRatedMovies = Provider.of<MoviesProvider>(context).topRatedMovies;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(true),
      drawer: MyDrawer(),
      //if loading movies or empty show loading spinner else show page
      body: popularMovies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              //controller: pageController,
              child: Column(children: [
                TopMovie(
                  popularMovies[0],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today's must watch",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                RowOfMovies(popularMovies),
                Divider(),
                Container(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Rated Films",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                RowOfMovies(topRatedMovies),
              ]),
            ),
    );
  }
}
