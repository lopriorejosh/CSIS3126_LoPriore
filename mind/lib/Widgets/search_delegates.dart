import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Models/friend_model.dart';
import 'package:provider/provider.dart';

import '../Providers/movies_provider.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';
import '../Screens/movie_description_page.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<Movie> friendMatches = [];

  Future<void> searchMovie(String queryToSearch) async {
    final url = Uri.parse(ApiConstants.searchMovieEndpoint + query);
    var response = await http.get(url);
    print(response.body);
    //make list of friendMatches
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
    return friendMatches.isEmpty
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
                  friendMatches[index].title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: (() => Navigator.of(context).pushNamed(
                      MovieDescriptionPage.routeName,
                      arguments: Movie(
                          title: friendMatches[index].title,
                          description: friendMatches[index].description,
                          id: friendMatches[index].id,
                          imageUrl: friendMatches[index].imageUrl,
                          genres: friendMatches[index].genres,
                          video: friendMatches[index].video,
                          watchProviders: friendMatches[index].watchProviders,
                          reviews: friendMatches[index].reviews,
                          runtime: friendMatches[index].runtime),
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

class FriendSearchDelegate extends SearchDelegate {
  List<Friend> friendMatches = [];

  Future<void> searchFriend(String queryToSearch) async {
    //make list of friendMatches
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
    searchFriend(query);
    //display list
    return friendMatches.isEmpty
        ? Center(
            child: Text(
              'No Friend Matches',
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
                  friendMatches[index].username,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: () {
                  //add friend
                },
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Text(
      'Search Results Will Display Here',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.caption,
    ));
  }
}
