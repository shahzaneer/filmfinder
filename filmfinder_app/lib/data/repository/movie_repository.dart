import 'package:filmfinder_app/data/exceptions/app_exceptions.dart';
import 'package:filmfinder_app/data/network/api_service.dart';
import 'package:filmfinder_app/data/repository/movie_services.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/data/network/end_points.dart';

//! The Repository layer is to complete the abstraction of the data layer and to provide a clean API for the ViewModel to communicate with.

class MovieRepository extends MovieServices {
  final ApiService _apiService = ApiService();

  @override
  Future<List<String>> getMovieGenres(MovieModel movie) async {
    List<String> genresList = [];
    try {
      final response = await _apiService.get(
          movieId: null,
          searchedQuery: null,
          givenEndPoint: endPoints.movieGenre);
      for (var genre in response['genres']) {
        if (movie.genreIds.contains(genre['id'])) {
          genresList.add(genre['name']);
        }
      }
    } catch (error) {
      throw InternetException(error.toString());
    }

    return genresList;
  }

  @override
  Future<String> getMovieTrailer(String movieId) async {
    late String trailerkey;
    try {
      final response = await _apiService.get(
          movieId: movieId,
          searchedQuery: null,
          givenEndPoint: endPoints.movieTrailer);
      for (var dataMembers in response['results'][0]) {
        if (dataMembers['type'] == 'Trailer') {
          trailerkey = dataMembers['key'];
        }
      }
    } catch (error) {
      throw InternetException(error.toString());
    }

    return trailerkey;
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    List<MovieModel> moviesList = [];
    try {
      final response = await _apiService.get(
          movieId: null,
          searchedQuery: null,
          givenEndPoint: endPoints.upcomingMovies);
      moviesList = response['results']
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } catch (error) {
      throw InternetException(error.toString());
    }

    return moviesList;
  }

  @override
  Future<List<MovieModel>> searchMovies(String searchedQuery) async {
    List<MovieModel> moviesSearchedList = [];
    try {
      final response = await _apiService.get(
          movieId: null,
          searchedQuery: searchedQuery,
          givenEndPoint: endPoints.movieSearch);
      moviesSearchedList = response['results']
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } catch (error) {
      throw InternetException(error.toString());
    }

    return moviesSearchedList;
  }

}

void main(List<String> args) {
  // Testing the Repository Layer
  // MovieRepository movieRepository = MovieRepository();
  // movieRepository.getUpcomingMovies().then((value) => print(value));
}
