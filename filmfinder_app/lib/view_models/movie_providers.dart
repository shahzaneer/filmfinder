import 'package:filmfinder_app/data/repository/movie_repository.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:flutter/material.dart';

// This class will provide the data to the UI i.e. It is serving as the viewModel Class
// It will be used to notify the UI about the changes in the data
class MovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();
  List<MovieModel> allMoviesList = [];
  List<MovieModel> searchedMoviesList = [];

  void getMovies() async {
    allMoviesList = await _movieRepository.getUpcomingMovies();
  
    // Linking to UI
    notifyListeners();
  }

  void searchMovies(String searchedQuery) async {
    searchedMoviesList = await _movieRepository.searchMovies(searchedQuery);
    // Linking to UI
    notifyListeners();
  }

  void getMovieTrailer(String movieId) async {
    String videoTrailerKey = await _movieRepository.getMovieTrailer(movieId);
    // Linking to UI
    notifyListeners();
  }

  void getMovieGenres(MovieModel movie) async {
    List<String> genereList = await _movieRepository.getMovieGenres(movie);
    // Linking to UI
    notifyListeners();
  }

  void getMoviesFromHive() {
    allMoviesList = _movieRepository.getMoviesFromHive();
    // Linking to UI
    notifyListeners();
  }

  void clearSearch() async {
    searchedMoviesList = [];

    // Linking to UI
    notifyListeners();
  }
}
