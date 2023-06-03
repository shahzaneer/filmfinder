import 'package:filmfinder_app/data/repository/movie_repository.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:filmfinder_app/views/movie_detail_screen/widgets/genere_tag.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/movie_searched_tile.dart';
import 'package:filmfinder_app/views/movie_home_screen/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// This class will provide the data to the UI i.e. It is serving as the viewModel Class
// It will be used to notify the UI about the changes in the data
class MovieProvider with ChangeNotifier {
  // Creating the instance of the MovieRepository
  final MovieRepository _movieRepository = MovieRepository();

  List<MovieTile> allMoviesListWidget = [];
  List<MovieSearchedTile> searchedMoviesListWidget = [];
  List<GenereTag> genereListWidget = [];
  bool loading = false;

//! Done
  void getMovies() async {
    try {
      loading = true;
      bool internet = await InternetConnectionChecker().hasConnection;
      List<MovieModel> movies;
      if (internet) {
        movies = await _movieRepository.getUpcomingMovies();
      } else {
        Utils.showFlutterToast("NO Internet! Checking in the Local DataBase");
        movies = _movieRepository.getMoviesFromHive();
      }
// Now Mapping the data to the UI
      allMoviesListWidget =
          movies.map((movie) => MovieTile(movie: movie)).toList();
    } catch (e) {
      loading = false;
      Utils.showErrorToast("Some error Occured! : $e");
    }
    loading = false;
    notifyListeners();
  }

//! Done
  void searchMovies(String searchedQuery) async {
    try {
      bool internet = await InternetConnectionChecker().hasConnection;
      if (internet) {
        loading = true;
        List<MovieModel> searchMovies =
            await _movieRepository.searchMovies(searchedQuery);
        searchedMoviesListWidget = searchMovies
            .map((movie) => MovieSearchedTile(movie: movie))
            .toList();
      } else {
        Utils.showErrorToast("No internet connection!");
      }
    } catch (e) {
      loading = false;
      Utils.showErrorToast("Some error Occured! : $e");
    }
    loading = false;
    notifyListeners();
  }

// ! Done
  Future<String> getMovieTrailer(String movieId) async {
    String videoTrailerKey = await _movieRepository.getMovieTrailer(movieId);
    return videoTrailerKey;
  }

//! Done
  void getMovieGenres(MovieModel movie) async {
    try {
      List<String> genereList = await _movieRepository.getMovieGenres(movie);
      for (var genereName in genereList) {
        genereListWidget.add(GenereTag(genereName: genereName));
      }
    } catch (e) {
      Utils.showErrorToast("No internet connection!");
    }
    notifyListeners();
  }

// ! Done
  void getMoviesFromHive() {
    List<MovieModel> movieList = _movieRepository.getMoviesFromHive();
    if (allMoviesListWidget.isEmpty) {
      for (var movie in movieList) {
        allMoviesListWidget.add(MovieTile(movie: movie));
      }
    }
    // Linking to UI
    notifyListeners();
  }

//! Done
  void clearSearch() async {
    searchedMoviesListWidget.clear();
    getMovies();
    notifyListeners();
  }
}
