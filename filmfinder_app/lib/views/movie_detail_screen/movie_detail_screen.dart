import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/genere_tag.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_overview.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/movie_poster.dart';
import 'package:flutter/material.dart';

class MoviesDetailsScreen extends StatefulWidget {
  final MovieModel movie;
  const MoviesDetailsScreen({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
            MoviePoster(
              movie: widget.movie,
            ),
            Divider(
              color: Colors.grey.shade50,
              thickness: 0.2,
            ),
            MovieOverview(movie: widget.movie),
          ],
        ),
      ),
    );
  }
}
