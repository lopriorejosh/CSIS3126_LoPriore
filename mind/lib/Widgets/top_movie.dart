import 'package:flutter/material.dart';

import '../Screens/movie_description_page.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';

class TopMovie extends StatelessWidget {
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
  TopMovie({
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
    return InkWell(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .6,
              child: Image.network(
                ApiConstants.imageEndpoint +
                    ApiConstants.originalImageEndpoint +
                    backdropPath,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Text(
                "Todays #1: $title",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
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
              //Navigator.of(context).pushNamed(MovieDescriptionPage.routeName, arguments: Movie),
            ));
  }
}
