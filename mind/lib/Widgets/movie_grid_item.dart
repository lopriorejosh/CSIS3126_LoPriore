import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mind/API/api_constants.dart';

import '../Screens/movie_description_page.dart';
import '../Models/movie_model.dart';

class MovieGridItem extends StatelessWidget {
  //bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  //String originalLanguage;
  //String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  //double voteAverage;
  //int voteCount;

  MovieGridItem({
    //required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    //required this.originalLanguage,
    //required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    //required this.voteAverage,
    //required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          MovieDescriptionPage.routeName,
          arguments: Movie(
            title: title,
            overview: overview,
            id: id,
            backdropPath: backdropPath,
            genreIds: genreIds,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            video: video,
          ),
        ),
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Image.network(ApiConstants.imageEndpoint +
                ApiConstants.originalImageEndpoint +
                backdropPath),
          ),
          SizedBox(
            height: 50,
            width: 250,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        ]),
      ),
    );
  }
}
