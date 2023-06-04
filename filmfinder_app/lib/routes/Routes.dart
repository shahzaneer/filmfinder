import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/routes/route_names.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/movie_tile.dart';
import 'package:filmfinder_app/views/search_screen.dart/movie_search_screen.dart';
import 'package:flutter/material.dart';
import '../views/movie_detail_screen/movie_detail_screen.dart';
import '../views/movie_home_screen/movie_home_screen.dart';
import '../views/movie_ticket_screen/movie_ticket_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.movieHome:
        return MaterialPageRoute(builder: (context) => const MovieHomeScreen());
      case RoutesNames.movieDetails:
        return MaterialPageRoute(
            builder: (context) =>
                MoviesDetailsScreen(movie: settings.arguments as MovieModel));
      case RoutesNames.movieTicket:
        return MaterialPageRoute(
            builder: (context) => const MovieTicketScreen());
      case RoutesNames.movieSearch:
        return MaterialPageRoute(
          builder: (context) => MovieSearchScreen(
            movieTile: settings.arguments as List<MovieTile>,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("No Route defined"),
                ),
              ),
            );
          },
        );
    }
  }
}

//! All the routes will by generated by this function
