import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:filmfinder_app/data/network/api_urls.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/routes/route_names.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  MovieModel movie;
  //! Sample data For Widget Building
  // MovieModel movie = MovieModel(
  //     originalTitle: "originalTitle",
  //     id: "1",
  //     genreIds: [],
  //     backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg");
  MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.movieDetails,
            arguments: movie);
      },
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: height * 0.23,
          width: width * 0.9,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FastCachedImage(
                  url: "${ApiUrls.baseImageUrl}${movie.backdropPath}",
                  loadingBuilder: (p0, p1) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (p0, p1, p2) {
                    // debugPrint("Error: $p2");
                    return Container(
                      color: Colors.grey,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 19,
                left: 12,
                child: Text(
                  movie.originalTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
