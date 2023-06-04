import 'package:filmfinder_app/routes/route_names.dart';
import 'package:filmfinder_app/utils/coloors.dart';
import 'package:filmfinder_app/view_models/movie_providers.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:provider/provider.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coolors.kAppBarBackgroundColor,
        toolbarHeight: 90,
        title: const Text(
          "Watch",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 7),
            child: Consumer<MovieProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.movieSearch,
                        arguments: value.allMoviesListWidget);
                  },
                  child: const Icon(Icons.search),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, value, child) {
          return Center(
            child: value.loading
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : ListView(
                    children: value.allMoviesListWidget,
                  ),
          );
        },
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
