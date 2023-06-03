import 'package:filmfinder_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer({super.key, required this.trailerId});

  final String trailerId;

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
      initialVideoId: "someVideoID",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

  @override
  void initState() {
    super.initState();

    initializeTrailer();
  }

  void initializeTrailer() async {
    String videoId = widget.trailerId;
    // String youtubeLink = "https://www.youtube.com/watch?v=";
    // String videoBaseUrl = "$youtubeLink$videoId";
    bool isInternetAvailable = await InternetConnectionChecker().hasConnection;
    if (videoId.isEmpty && isInternetAvailable) {
      Utils.showErrorToast("No trailer available");
      return;
    }
    if (!isInternetAvailable) {
      Utils.showErrorToast("No internet connection!");
      return;
    }
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController.dispose();
  }

  bool showVideo = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayer(
          controller: youtubePlayerController,
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
