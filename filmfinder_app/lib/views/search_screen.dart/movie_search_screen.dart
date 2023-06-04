// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/movie_tile.dart';
import 'package:filmfinder_app/views/search_screen.dart/widgets/categories_grid.dart';
import 'package:filmfinder_app/views/search_screen.dart/widgets/movie_searched_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchScreen extends StatefulWidget {
  List<MovieSearchedTile> movieTile;

  MovieSearchScreen({
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
    // final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coolors.kAppBarBackgroundColor,
        toolbarHeight: 90,
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 7),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showGrid = false;
                });
              },
              child: AnimSearchBar(
                color: Coolors.kBackgroundColor,
                width: size.width * 0.9,
                textController: _searchController,
                helpText: "TV shows, Movies & More",
                onSuffixTap: () {
                  setState(() {
                    _searchController.clear();
                  });
                },
                onSubmitted: (text) {
                  if (text.isEmpty && text.length == 1) {
                    setState(() {
                      showGrid = true;
                    });
                    // show ListView
                  } else if (text.length > 1) {
                    showGrid = false;
                  }
                },
                rtl: true,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, value, child) {
          return Center(
            child: showGrid
                ? const CategoriesGrid()
                : ListView(
                    children: value.searching
                        ? value.searchedMoviesListWidget
                        : widget.movieTile),
          );
        },
      ),
    );
  }
}
