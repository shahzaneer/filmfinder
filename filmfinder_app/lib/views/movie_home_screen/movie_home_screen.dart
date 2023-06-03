import 'package:filmfinder_app/utils/coloors.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              onSubmitted: (text) {},
              rtl: true,
            ),
          ),
        ],
      ),
      body: const Center(
        // child: ListView(children: [
        // ]),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
