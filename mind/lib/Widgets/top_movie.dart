import 'package:flutter/material.dart';

import '../Screens/movie_description_page.dart';
import '../Models/movie_model.dart';
import '../API/api_constants.dart';

class TopMovie extends StatelessWidget {
  Movie topMovie;

  TopMovie(this.topMovie);

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
              topMovie.backdropPath,
          fit: BoxFit.fitHeight,
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Positioned(
        bottom: 50,
        left: 50,
        //height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.width,
        child: Text(
          topMovie.title,
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
                title: topMovie.title,
                overview: topMovie.overview,
                id: topMovie.id,
                backdropPath: topMovie.backdropPath,
                genreIds: topMovie.genreIds,
                popularity: topMovie.popularity,
                posterPath: topMovie.posterPath,
                releaseDate: topMovie.releaseDate,
                video: topMovie.video,
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
