import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/movie_tile.dart';
import 'package:filmfinder_app/views/search_screen.dart/widgets/categories_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchScreen extends StatefulWidget {
  final List<MovieTile> movieTile;

  const MovieSearchScreen({
    Key? key,
    required this.movieTile,
  }) : super(key: key);

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final _searchController = TextEditingController();
  bool showGrid = true;

  @override
  void initState() {
    super.initState();
  }

  void search() {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.searchMovies(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coolors.kAppBarBackgroundColor,
        toolbarHeight: 90,
        title: AnimatedSearchBar(
          label: "TV shows, Movies & more",
          controller: _searchController,
          labelStyle: const TextStyle(fontSize: 16),
          searchStyle: const TextStyle(color: Colors.black),
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          searchDecoration: const InputDecoration(
            alignLabelWithHint: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            search();
            if (value.isEmpty && value.length == 1) {
              setState(() {
                showGrid = true;
              });
            } else {
              setState(() {
                showGrid = false;
              });
            }
          },
          onFieldSubmitted: (value) {
            Utils.showFlutterToast("Hello!");
          },
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, value, child) {
          return Center(
            child: showGrid
                ? const CategoriesGrid()
                : ListView(children: value.searchedMoviesListWidget),
          );
        },
      ),
    );
  }
}

