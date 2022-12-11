import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/row_of_genres.dart';
import '../Models/genre_model.dart';
import '../Models/movie_model.dart';

class MovieDetailTab extends StatelessWidget {
  Movie _movie;
  List<Genre> genres = [];

  MovieDetailTab(this._movie);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .4,
      child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  _movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            width: double.infinity,
            child: Center(
              child: FittedBox(
                  child: Text(
                _movie.tagline!.isNotEmpty
                    ? _movie.tagline.toString()
                    : 'No Tagline',
                style: Theme.of(context).textTheme.caption,
              )),
            ),
          ),
          Divider(),
          Center(
            child: FittedBox(
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _movie.overview.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(
              height: 50,
              child: Text(
                'Runtime: ' + _movie.runtime.toString() + ' min.',
                style: Theme.of(context).textTheme.labelSmall,
              )),
          SizedBox(
              height: 50,
              child: Text(
                'Release Date: ' + _movie.release_date.toString(),
                style: Theme.of(context).textTheme.labelSmall,
              )),
          SizedBox(
              height: 50,
              child: Text(
                'Popularity: ' + _movie.runtime.toString() + ' rating',
                style: Theme.of(context).textTheme.labelSmall,
              )),
        ],
      ),
    );
  }
}
