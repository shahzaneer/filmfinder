import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:filmfinder_app/data/network/api_urls.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/routes/route_names.dart';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final MovieModel movie;
  final Function showTrailer;

  //! Sample data For Widget Building
  // MovieModel movie = MovieModel(
  //     originalTitle: "originalTitle",
  //     id: "1",
  //     genreIds: [],
  //     backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg");

  const MoviePoster({
    Key? key,
    required this.movie,
    required this.showTrailer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = Utils.dateEnhancer(movie.releaseDate);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FastCachedImage(
          height: height * 0.6,
          width: width,
          url: "${ApiUrls.baseImageUrl}${movie.posterPath}",
          loadingBuilder: (p0, p1) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (p0, p1, p2) {
            return Container(
              color: Colors.grey,
            );
          },
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.6,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "In Theaters Release on $date",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 260,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesNames.movieTicket);
                    },
                    color: Coolors.kLightBlue,
                    pressedOpacity: 0.8,
                    borderRadius: BorderRadius.circular(10),
                    child: const Text("Get Tickets"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Coolors.kLightBlue),
                  ),
                  child: CupertinoButton(
                    onPressed: () {
                      showTrailer();
                    },
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow),
                        Text("Watch Trailer"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
