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
    return Stack(children: [
      ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          ApiConstants.imageEndpoint +
              ApiConstants.originalImageEndpoint +
              backdropPath,
          fit: BoxFit.fitHeight,
          height: MediaQuery.of(context).size.height * .6,
        ),
      ),
      Positioned(
        bottom: 50,
        left: 50,
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      Positioned(
        right: 10,
        bottom: 10,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
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
            );
          },
          icon: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
        ),
      )
    ]);
  }
}
