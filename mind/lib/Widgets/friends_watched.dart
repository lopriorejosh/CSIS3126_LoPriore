import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/user_model.dart';
import '../Providers/account_provider.dart';
import '../Models/movie_model.dart';
import '../Providers/movies_provider.dart';

class FriendCard extends StatelessWidget {
  Movie lastMovieWatched;
  User friend;

  FriendCard(this.friend, this.lastMovieWatched);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  //change to profile pic
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        friend.username.toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 3,
              child: Text(
                lastMovieWatched.title,
                style: Theme.of(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendsWatched extends StatefulWidget {
  @override
  State<FriendsWatched> createState() => _FriendsWatchedState();
}

class _FriendsWatchedState extends State<FriendsWatched> {
  ScrollController scroller = ScrollController(keepScrollOffset: false);

  @override
  Widget build(BuildContext context) {
    var popularMovies = Provider.of<MoviesProvider>(context).popularMovies;
    var friends = Provider.of<AccountProvider>(context).friendsList;

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
          height: MediaQuery.of(context).size.height * .5,
          //width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: EdgeInsets.only(
                top: 0, bottom: MediaQuery.of(context).size.height * .15),
            controller: scroller,
            children: [
              FriendCard(friends[0], popularMovies[0]),
              /*FriendCard(friends[1], popularMovies[1]),
              FriendCard(friends[2], popularMovies[2]),
              FriendCard(friends[2], popularMovies[3]),
              FriendCard(friends[2], popularMovies[4]),
              FriendCard(friends[2], popularMovies[5]),
              FriendCard(friends[2], popularMovies[6]),
              FriendCard(friends[2], popularMovies[7]),
              FriendCard(friends[2], popularMovies[8]),
              FriendCard(friends[2], popularMovies[9]),*/
            ],
          ),
        ),
      ],
    );
  }
}
