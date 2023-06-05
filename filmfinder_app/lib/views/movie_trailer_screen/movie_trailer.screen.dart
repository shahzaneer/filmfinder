import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/views/movie_trailer_screen/widgets/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MovieTrailerScreen extends StatefulWidget {
  final MovieModel movie;
  const MovieTrailerScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieTrailerScreen> createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  bool playTrailer = false;
  bool internetConnection = false;

  @override
  void initState() {
    super.initState();
    showTrailer();
  }

  void showTrailer() async {
    print("show Trailer Main Screen");
    internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection) {
      print("Internet tou hai boss");
      setState(() {
        playTrailer = true;
      });
    } else {
      print("Internet nhi hai");
      Utils.showErrorToast("Internet k Bagair Video kese chalegi bhai?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: playTrailer
          ? TrailerPlayer(
              onIconPressed: () => Navigator.pop(context),
              movieID: widget.movie.id,
            )
          : Center(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: Text("waiting for the Connection"),
                ),
              ),
            ),
    );
  }
}
