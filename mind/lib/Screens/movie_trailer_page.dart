import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mind/Widgets/my_appbar.dart';
import 'package:mind/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerPage extends StatefulWidget {
  static const routeName = '/youtubePlayer';

  const MovieTrailerPage({super.key});

  @override
  State<MovieTrailerPage> createState() => _MovieTrailerPageState();
}

class _MovieTrailerPageState extends State<MovieTrailerPage> {
  final url = 'https://www.youtube.com/watch?v=X0tOpBuYasI';

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(url);

    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                    playedColor: Theme.of(context).backgroundColor,
                    handleColor: Theme.of(context).primaryColorLight),
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
        ),
      ),
    );
  }
}
