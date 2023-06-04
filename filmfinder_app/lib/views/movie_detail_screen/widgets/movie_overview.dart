import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieOverview extends StatefulWidget {
  final MovieModel movie;
  //! Sample data For Widget Building
  // MovieModel movie = MovieModel(
  //     originalTitle: "originalTitle",
  //     id: "1",
  //     genreIds: [],
  //     backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg");

  const MovieOverview({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieOverview> createState() => _MovieOverviewState();
}

class _MovieOverviewState extends State<MovieOverview> {
  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getMovieGenres(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "  Generes",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Consumer<MovieProvider>(
          builder: (context, value, child) {
            return Wrap(
              spacing: 7,
              children: value.genereListWidget,
            );
          },
        ),
        const Text(
          "  Overview",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${widget.movie.overview}",
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
