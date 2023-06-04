// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:filmfinder_app/data/network/api_urls.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/routes/route_names.dart';
import 'package:flutter/material.dart';

class MovieSearchedTile extends StatelessWidget {
  MovieModel movie;

  MovieSearchedTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  //! Sample data For Widget Building
  // MovieModel movie = MovieModel(
  //     originalTitle: "originalTitle",
  //     id: "1",
  //     genreIds: [],
  //     backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.movieDetails,
            arguments: movie);
      },
      child: SizedBox(
        width: double.infinity,
        height: height * 0.18,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.03),
                child: SizedBox(
                  height: height * 0.125,
                  width: width * 0.44,
                  child: ClipRRect(
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
                ),
              ),
            ),
            Expanded(
              child: SizedBox(width: width * 0.01),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      movie.originalTitle,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "genre",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: const Icon(Icons.more_horiz_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
