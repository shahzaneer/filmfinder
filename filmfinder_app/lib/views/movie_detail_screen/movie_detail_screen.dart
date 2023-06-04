// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/genere_tag.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_overview.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_poster.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MoviesDetailsScreen extends StatefulWidget {
  MovieModel movie;
  MoviesDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  bool playTrailer = false;
  var videoKey = "";
  List<GenereTag> genereList = [];

  @override
  void initState() {
    super.initState();
  }

  void showTrailer() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    videoKey = await movieProvider.getMovieTrailer(widget.movie.id);

    bool internetConnection = await InternetConnectionChecker().hasConnection;

    if (internetConnection) {
      setState(() {
        playTrailer = true;
      });
    } else {
      Utils.showErrorToast("Internet k Bagair Video kese chalegi bhai?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          playTrailer
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      playTrailer = false;
                    });
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(
                  height: 0,
                )
        ],
        elevation: 0,
        title: const Text(
          'Watch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            playTrailer
                ? TrailerPlayer(
                    trailerId: videoKey,
                  )
                : MoviePoster(
                    movie: widget.movie,
                    showTrailer: showTrailer,
                  ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            MovieOverview(movie: widget.movie),
          ],
        ),
      ),
    );
  }
}
