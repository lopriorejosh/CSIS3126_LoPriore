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
              topMovie.backdrop_path.toString(),
          fit: BoxFit.fitHeight,
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Positioned(
        bottom: 50,
        left: 10,
        height: MediaQuery.of(context).size.height * .1,
        width: MediaQuery.of(context).size.width,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            topMovie.title,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
          ),
        ),
      ),
      Positioned(
        right: 10,
        bottom: 10,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MovieDescriptionPage.routeName,
                arguments: Movie(
                    adult: topMovie.adult,
                    backdrop_path: topMovie.backdrop_path,
                    budget: topMovie.budget,
                    genres: topMovie.genres,
                    id: topMovie.id,
                    original_language: topMovie.original_language,
                    original_title: topMovie.original_title,
                    overview: topMovie.overview,
                    popularity: topMovie.popularity,
                    poster_path: topMovie.poster_path,
                    release_date: topMovie.release_date,
                    revenue: topMovie.revenue,
                    runtime: topMovie.runtime,
                    tagline: topMovie.tagline,
                    title: topMovie.title,
                    video: topMovie.video,
                    watchProviders: topMovie.watchProviders));
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
