import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_overview.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_poster.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MoviesDetailsScreen extends StatelessWidget {
  MoviesDetailsScreen({super.key});

  ValueNotifier playTrailer = ValueNotifier(false);

  void showTrailer() async {
    bool internetConnection = await InternetConnectionChecker().hasConnection;

    if (internetConnection) {
        playTrailer.value = true;
    } else {
      Utils.showErrorToast("Internet k Bagair Video kese chalegi bhai?");
    }
  }

  //! Sample data For Widget Building
  MovieModel movie = MovieModel(
      originalTitle: "originalTitle",
      id: "1",
      genreIds: [],
      backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg",
      posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg");

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: playTrailer,
      builder:(context, value, child){
        return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            playTrailer.value
                ? IconButton(
                    onPressed: () {
                        playTrailer.value = false;
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
          child: Column(children: [
            playTrailer.value
                ? const TrailerPlayer(trailerId: "rwU0aYVc8cQ")
                : MoviePoster(
                    movie: movie,
                    showTrailer: showTrailer,
                  ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            MovieOverview(movie: movie),
          ]),
        ),
      );
}
    );
  }
}
