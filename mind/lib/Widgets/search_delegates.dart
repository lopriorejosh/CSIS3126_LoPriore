import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mind/Providers/account_provider.dart';
import 'package:provider/provider.dart';

import '../Models/user_model.dart';
import '../Providers/movies_provider.dart';
import '../Models/movie_model.dart';
import '../Screens/movie_description_page.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<Movie> movieMatches = [];

  Future<void> searchMovie(String queryToSearch) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=ffd47d62f4e4b8d58336acf31f7c2550&language=en-US&query=Jack%2BReacher&page=1&include_adult=false');
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
    return movieMatches.isEmpty
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
