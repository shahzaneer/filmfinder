import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerPlayer extends StatefulWidget {
  TrailerPlayer({super.key, required this.movieID});

  final String movieID;
  String videoKey = "";

  var controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  @override
  void initState() {
    super.initState();
    print("Before Initialization");
    initializeTrailer();
  }

  void initializeTrailer() async {
    String movieID = widget.movieID;
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    widget.videoKey = await movieProvider.getMovieTrailer(movieID);
    String youtubeLink = "https://www.youtube.com/watch?v=";

    bool isInternetAvailable = await InternetConnectionChecker().hasConnection;
    if (widget.movieID.isEmpty || widget.videoKey.isEmpty) {
      Utils.showErrorToast("No trailer available");
      return;
    }
    if (!isInternetAvailable) {
      Utils.showErrorToast("No internet connection!");
      return;
    }
    // If the requirement is just to play a single video.
    widget.controller = YoutubePlayerController.fromVideoId(
      // videoId: widget.videoKey,
      videoId: "ueZbo_bQHMg",
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    String videoBaseUrl = "$youtubeLink${widget.videoKey}";

    print("The URL for the Trailer Video is : $videoBaseUrl");
  }

  bool showVideo = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayer(
          controller: widget.controller,
          aspectRatio: 0.6,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              showVideo = false;
            });
          },
          icon: const Icon(Icons.clear),
        ),
      ],
    );
  }
}
