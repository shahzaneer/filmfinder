import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  TrailerPlayer({super.key, required this.movieID});

  final String movieID;
  String videoKey = "";
  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  YoutubePlayerController? youtubePlayerController;

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
    // String youtubeLink = "https://www.youtube.com/watch?v=";

    bool isInternetAvailable = await InternetConnectionChecker().hasConnection;
    if (widget.movieID.isEmpty || widget.videoKey.isEmpty) {
      Utils.showErrorToast("No trailer available");
      return;
    }
    if (!isInternetAvailable) {
      Utils.showErrorToast("No internet connection!");
      return;
    }
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    setState(() {});
    // String videoBaseUrl = "$youtubeLink${widget.videoKey}";

    // print("The URL for the Trailer Video is : $videoBaseUrl");
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController!.dispose();
  }

  bool showVideo = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (youtubePlayerController != null &&
            !youtubePlayerController!.value.isReady)
          YoutubePlayer(
            controller: youtubePlayerController!,
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
