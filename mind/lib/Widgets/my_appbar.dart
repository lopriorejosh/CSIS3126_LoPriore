import 'package:flutter/material.dart';
import 'package:mind/Providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../API/api_constants.dart';
import '../Providers/account_provider.dart';
import '../Models/movie_model.dart';
import '../Screens/movie_description_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool haveSearch;

  MyAppBar(this.haveSearch);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AccountProvider>(context, listen: false);

    return AppBar(
        elevation: 0,
        title: Text(
          'Mind',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: !haveSearch
            ? null
            : [
                IconButton(
                    onPressed: () {
                      //navigate to search page
                      //Navigator.of(context).pushNamed('/searchMovie');
                      showSearch(
                          context: context, delegate: MySearchDelegate());
                    },
                    icon: const Icon(Icons.search)),
              ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}

class MySearchDelegate extends SearchDelegate {
  List<Movie> matches = [];

  Future<void> searchMovie(String queryToSearch) async {
    final url = Uri.parse(ApiConstants.searchMovieEndpoint + 'Jack+Reacher');
    var response = await http.get(url);
    print(response.body);
    //make list of matches
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    //query the api db
    searchMovie(query);
    //display list
    return matches.isEmpty
        ? Center(
            child: Text(
              'No Matches',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        : ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  textAlign: TextAlign.center,
                  matches[index].title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: (() => Navigator.of(context).pushNamed(
                      MovieDescriptionPage.routeName,
                      arguments: Movie(
                          title: matches[index].title,
                          description: matches[index].description,
                          id: matches[index].id,
                          imageUrl: matches[index].imageUrl,
                          genres: matches[index].genres,
                          video: matches[index].video,
                          watchProviders: matches[index].watchProviders,
                          reviews: matches[index].reviews,
                          runtime: matches[index].runtime),
                    )),
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = Provider.of<MoviesProvider>(context).popularMovies;
    if (suggestionList.isEmpty) {
      return Text(
        'No Suggestions',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall,
      );
    } else {
      return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                textAlign: TextAlign.center,
                suggestionList[index].title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onTap: (() => Navigator.of(context).pushNamed(
                    MovieDescriptionPage.routeName,
                    arguments: Movie(
                      title: suggestionList[index].title,
                      description: suggestionList[index].description,
                      id: suggestionList[index].id,
                      imageUrl: suggestionList[index].imageUrl,
                      genres: suggestionList[index].genres,
                      watchProviders: suggestionList[index].watchProviders,
                      reviews: suggestionList[index].reviews,
                      runtime: suggestionList[index].runtime,
                      video: suggestionList[index].video,
                    ),
                  )),
            );
          });
    }
  }
}
