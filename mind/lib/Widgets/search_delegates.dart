import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Providers/account_provider.dart';
import 'package:provider/provider.dart';

import '../Models/user_model.dart';
import '../Models/results_model.dart';
import '../Providers/movies_provider.dart';
import '../Models/movie_model.dart';
import '../Screens/movie_description_page.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<Movie> movieMatches = [];

  Future<List<Movie>> searchMovie(String queryToSearch) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US&query=${query}');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final _json = json.decode(response.body);
        //log(response.body);
        return List<Movie>.from(
            _json['results'].map((movie) => Movie.fromJson(movie)));
        //convertFromList(response.body).results;
        //movieMatches = _fetchedMovies;
      }
    } catch (error) {
      print(error);
    }
    return [];
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
              movieMatches.clear();
            }
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    //movieMatches.clear();
    //query the api db
    //searchMovie(query);
    //display list
    return /*movieMatches.isEmpty
        ? Center(
            child: Text(
              'No Matches',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        :*/
        /*ListView.builder(
            itemCount: movieMatches.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  textAlign: TextAlign.center,
                  movieMatches[index].title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: (() => Navigator.of(context).pushNamed(
                      MovieDescriptionPage.routeName,
                      arguments: Movie(
                          title: movieMatches[index].title,
                          description: movieMatches[index].description,
                          id: movieMatches[index].id,
                          imageUrl: movieMatches[index].imageUrl,
                          genres: movieMatches[index].genres,
                          video: movieMatches[index].video,
                          watchProviders: movieMatches[index].watchProviders,
                          reviews: movieMatches[index].reviews,
                          runtime: movieMatches[index].runtime),
                    )),
              );
            });*/
        FutureBuilder(
            future: searchMovie(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          textAlign: TextAlign.center,
                          snapshot.data![index].title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        onTap: (() => Navigator.of(context).pushNamed(
                            MovieDescriptionPage.routeName,
                            arguments: Movie(
                                adult: snapshot.data![index].adult,
                                backdrop_path:
                                    snapshot.data![index].backdrop_path,
                                budget: snapshot.data![index].budget,
                                genres: snapshot.data![index].genres,
                                id: snapshot.data![index].id,
                                original_language:
                                    snapshot.data![index].original_language,
                                original_title:
                                    snapshot.data![index].original_title,
                                overview: snapshot.data![index].overview,
                                popularity: snapshot.data![index].popularity,
                                poster_path: snapshot.data![index].poster_path,
                                release_date:
                                    snapshot.data![index].release_date,
                                revenue: snapshot.data![index].revenue,
                                runtime: snapshot.data![index].runtime,
                                tagline: snapshot.data![index].tagline,
                                title: snapshot.data![index].title,
                                video: snapshot.data![index].video,
                                watchProviders:
                                    snapshot.data![index].watchProviders))),
                      );
                    });
              }
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
                      adult: suggestionList[index].adult,
                      backdrop_path: suggestionList[index].backdrop_path,
                      budget: suggestionList[index].budget,
                      genres: suggestionList[index].genres,
                      id: suggestionList[index].id,
                      original_language:
                          suggestionList[index].original_language,
                      original_title: suggestionList[index].original_title,
                      overview: suggestionList[index].overview,
                      popularity: suggestionList[index].popularity,
                      poster_path: suggestionList[index].poster_path,
                      release_date: suggestionList[index].release_date,
                      revenue: suggestionList[index].revenue,
                      runtime: suggestionList[index].runtime,
                      tagline: suggestionList[index].tagline,
                      title: suggestionList[index].title,
                      video: suggestionList[index].video,
                      watchProviders: suggestionList[index].watchProviders))),
            );
          });
    }
  }
}

class FriendSearchDelegate extends SearchDelegate {
  List<User> friendMatches = [];
  final ref = FirebaseDatabase.instance.ref('users');

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
              friendMatches.clear();
            }
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final friendsProvider =
        Provider.of<AccountProvider>(context, listen: false);
    //query the api db
    //display list

    return FutureBuilder(
        future:
            ref.orderByChild('username').equalTo(query).limitToFirst(10).once(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(
              child:
                  Text('No Users Found. Try Again. Search is Case Sensitive.'),
            );
          }
          if (snapshot.hasData &&
              query.isNotEmpty &&
              snapshot.data!.snapshot.value != null) {
            friendMatches.clear();

            Map<dynamic, dynamic> values =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            print(values);
            values.forEach((key, value) {
              User newFriend = User(
                UID: key,
                username: value['username'],
                fname: value['fname'],
                lname: value['lname'],
              );
              friendMatches.add(newFriend);
            });
          }
          return ListView.builder(
              itemCount: friendMatches.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(friendMatches[index].username.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => friendsProvider.addFriend(
                        friendMatches[index], context),
                  ),
                );
              }));
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Text(
      'Search Users By Username. Search Is Case Sensitive.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.caption,
    ));
  }
}
