import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Widgets/my_appbar.dart';
import '../Widgets/movie_grid_item.dart';
import '../Screens/movie_description_page.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';
import '../Widgets/top_movie.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  var pageController = PageController();

  var appBar = MyAppBar();

  @override
  void initState() {
    //initial pull of data before build
    Provider.of<MoviesProvider>(context, listen: false).FetchPopularMovies();
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    var movieData = Provider.of<MoviesProvider>(context).popularMovies;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Image.network(
              fit: BoxFit.fill,
              '/wSqAXL1EHVJ3MOnJzMhUngc8gFs.jpg',
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text('Home'),
            leading: Icon(Icons.home),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('Friends'),
            leading: Icon(Icons.people),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
          Divider(),
        ],
      )),
      body: movieData == null || movieData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: pageController,
              child: Column(children: [
                TopMovie(
                  imageUrl: ApiConstants.imageEndpoint +
                      ApiConstants.originalImageEndpoint +
                      movieData[0].backdropPath,
                  title: movieData[0].title,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Today's must watch",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (ctx, index) => MovieGridItem(
                            backdropPath: movieData[index].backdropPath,
                            genreIds: movieData[index].genreIds,
                            id: movieData[index].id,
                            overview: movieData[index].overview,
                            popularity: movieData[index].popularity,
                            posterPath: movieData[index].posterPath,
                            releaseDate: movieData[index].releaseDate,
                            title: movieData[index].title,
                            video: movieData[index].video,
                          )),
                ),
                Divider(),
                Placeholder(
                  fallbackHeight: MediaQuery.of(context).size.height * .75,
                )
              ]),
            ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.black,
        selectedIndex: selectedIndex,
        onItemSelected: ((index) {
          setState(() {
            selectedIndex = index;
          });
        }),
        barItems: [
          BarItem(
            filledIcon: Icons.home_filled,
            outlinedIcon: Icons.home,
          ),
          BarItem(
            filledIcon: Icons.connect_without_contact_rounded,
            outlinedIcon: Icons.connect_without_contact_outlined,
          )
        ],
      ),
    );
  }
}
