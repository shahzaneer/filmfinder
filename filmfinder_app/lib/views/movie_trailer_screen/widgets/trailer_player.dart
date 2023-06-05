import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer(
      {super.key, required this.movieID, required this.onIconPressed});

  final String movieID;
  final Function()? onIconPressed;

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  YoutubePlayerController? youtubePlayerController;
  bool? youtubePlayerIsReadyAndNotNull;
  String? videoKey;

  @override
  void initState() {
    super.initState();
    initializeTrailer();
  }

  void initializeTrailer() async {
    print("initializer Trailer Called");
    String movieID = widget.movieID;
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    print("Provider Called");
    videoKey = await movieProvider.getMovieTrailer(movieID);
    print("Key : $videoKey");
    bool isInternetAvailable = await InternetConnectionChecker().hasConnection;

    if (videoKey!.isEmpty || videoKey == "") {
      print("Dar-asal Muamlaat Khrab hain");
      print("Movie ID : ${widget.movieID} \n video key: $videoKey");
      Utils.showErrorToast("No trailer available");
      return;
    }
    if (!isInternetAvailable) {
      Utils.showErrorToast("No Internet connection!");
      return;
    }

    print("Before Initializing the controller");
    // Initializing the Controller
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoKey!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    setState(() {});
    youtubePlayerIsReadyAndNotNull = youtubePlayerController != null &&
        youtubePlayerController!.value.isReady;
    print("After initializing the controller");
    // Notify the UI to rebuild itself!
    if (youtubePlayerIsReadyAndNotNull!) {
      print("Youtube Player is Ready and not null");
      setState(() {
        youtubePlayerIsReadyAndNotNull = true;
      });
      print("After Setstate");
    }
  }

  @override
  void dispose() {
    if (youtubePlayerController != null) {
      youtubePlayerController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          if (youtubePlayerIsReadyAndNotNull!)
            YoutubePlayer(
              controller: youtubePlayerController!,
              aspectRatio: double.infinity,
            ),
          if (youtubePlayerIsReadyAndNotNull!)
            IconButton(
              onPressed: widget.onIconPressed,
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          if (youtubePlayerIsReadyAndNotNull == false)
            const CircularProgressIndicator(
              color: Colors.blue,
            )
        ],
      ),
    );
  }
}
