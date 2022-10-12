import 'package:flutter/material.dart';

import '../Widgets/movie_grid_item.dart';
import '../Models/movie_model.dart';

class RowOfMovies extends StatelessWidget {
  List<Movie> movies = [];

  RowOfMovies(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MovieGridItem(movies[0]),
            MovieGridItem(movies[1]),
            MovieGridItem(movies[2]),
            MovieGridItem(movies[3]),
            MovieGridItem(movies[4]),
            MovieGridItem(movies[5]),
            MovieGridItem(movies[6]),
            MovieGridItem(movies[7]),
            MovieGridItem(movies[8]),
            MovieGridItem(movies[9]),
          ],
        ),
      ),
    );
  }
}
