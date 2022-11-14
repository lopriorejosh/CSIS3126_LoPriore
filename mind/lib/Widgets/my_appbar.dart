import 'package:flutter/material.dart';
import 'package:mind/Providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../Providers/account_provider.dart';
import '../Models/movie_model.dart';
import '../Screens/movie_description_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
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
        actions: [
          IconButton(
              onPressed: () {
                //navigate to search page
                //Navigator.of(context).pushNamed('/searchMovie');
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}

class MySearchDelegate extends SearchDelegate {
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
    //make list of matches
    List<Movie> matches = [];
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
                        overview: matches[index].overview,
                        id: matches[index].id,
                        backdropPath: matches[index].backdropPath,
                        genreIds: matches[index].genreIds,
                        popularity: matches[index].popularity,
                        posterPath: matches[index].posterPath,
                        releaseDate: matches[index].releaseDate,
                        video: matches[index].video,
                      ),
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
                      overview: suggestionList[index].overview,
                      id: suggestionList[index].id,
                      backdropPath: suggestionList[index].backdropPath,
                      genreIds: suggestionList[index].genreIds,
                      popularity: suggestionList[index].popularity,
                      posterPath: suggestionList[index].posterPath,
                      releaseDate: suggestionList[index].releaseDate,
                      video: suggestionList[index].video,
                    ),
                  )),
            );
          });
    }
  }
}
