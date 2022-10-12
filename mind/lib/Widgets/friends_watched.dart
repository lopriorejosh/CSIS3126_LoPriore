import 'package:flutter/material.dart';
import 'package:mind/Providers/friends_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Models/friend_model.dart';
import '../Models/movie_model.dart';
import '../Providers/movies_provider.dart';

class FriendCard extends StatelessWidget {
  Movie lastMovieWatched;
  Friend friend;

  FriendCard(this.friend, this.lastMovieWatched);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              Text(
                friend.username,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          Text(
            lastMovieWatched.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      )),
    );
  }
}

class FriendsWatched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var popularMovies = Provider.of<MoviesProvider>(context).popularMovies;
    var friends = Provider.of<FriendsProvider>(context).friendsList;

    return Column(
      children: [
        Container(
          child: Text(
            textAlign: TextAlign.center,
            "Friends Recently Watched",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          width: double.infinity,
          child: ListView(children: [
            FriendCard(friends[0], popularMovies[0]),
            FriendCard(friends[1], popularMovies[1]),
            FriendCard(friends[2], popularMovies[3])
          ]),
        ),
      ],
    );
  }
}
