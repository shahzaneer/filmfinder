// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/genere_tag.dart';
import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  // MovieModel movie;
  //! Sample data For Widget Building
  MovieModel movie = MovieModel(
      originalTitle: "originalTitle",
      id: "1",
      genreIds: [],
      backdropPath: "/94TIUEhuwv8PhdIADEvSuwPljS5.jpg");

  MovieOverview({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "  Generes",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Wrap(
          spacing: 7,
          children: [
            GenereTag(genereName: "Action"),
            GenereTag(genereName: "Family"),
            GenereTag(genereName: "Cartoon"),
            GenereTag(genereName: "Horror"),
          ],
        ),
        const Text(
          "  Overview",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        const Padding(
          padding: EdgeInsets.only(left:8.0),
          child: Text(
            "Data here",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
