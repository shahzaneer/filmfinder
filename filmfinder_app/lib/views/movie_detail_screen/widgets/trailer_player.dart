import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer({super.key, required this.movieID});

  final String movieID;
  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  YoutubePlayerController? youtubePlayerController;
  String? videoKey;

  @override
  void initState() {
    super.initState();
    initializeTrailer();
  }

  void initializeTrailer() async {
    String movieID = widget.movieID;
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    videoKey = await movieProvider.getMovieTrailer(movieID);
    bool isInternetAvailable = await InternetConnectionChecker().hasConnection;
    if (widget.movieID.isEmpty || videoKey!.isEmpty) {
      Utils.showErrorToast("No trailer available");
      return;
    }
    if (!isInternetAvailable) {
      Utils.showErrorToast("No internet connection!");
      return;
    }
    // Initializing the Controller
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoKey!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    // Notify the UI to rebuild itself!
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController!.dispose();
  }

  bool showVideo = false;
  @override
  Widget build(BuildContext context) {
    if (youtubePlayerController != null &&
        !youtubePlayerController!.value.isReady) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: youtubePlayerController!,
          aspectRatio: 0.6,
        ),
        builder: (context, player) {
          return Column(
            children: [
              // some widgets
              player,
              //some other widgets
            ],
          );
        },
      );
    } else {
      return const CircularProgressIndicator(
        color: Colors.blue,
      );
    }
  }
}


// Stack(
//       children: [
//         if (youtubePlayerController != null &&
//             !youtubePlayerController!.value.isReady)
//           YoutubePlayer(
//             controller: youtubePlayerController!,
//             aspectRatio: 0.6,
//           ),
//         IconButton(
//           onPressed: () {
//             setState(() {
//               showVideo = false;
//             });
//           },
//           icon: const Icon(Icons.clear),
//         ),
//       ],
//     );