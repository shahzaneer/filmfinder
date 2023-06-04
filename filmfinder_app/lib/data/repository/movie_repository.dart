import 'package:filmfinder_app/data/exceptions/app_exceptions.dart';
import 'package:filmfinder_app/data/network/api_service.dart';
import 'package:filmfinder_app/data/repository/movie_services.dart';
import 'package:filmfinder_app/models/movie_model.dart';
import 'package:filmfinder_app/data/network/end_points.dart';
import 'package:filmfinder_app/utils/utils.dart';
import 'package:hive/hive.dart';

//! The Repository layer is to complete the abstraction of the data layer and to provide a clean API for the ViewModel to communicate with.

class MovieRepository extends MovieServices {
  final ApiService _apiService = ApiService();
  List<MovieModel> moviesListGlobal = [];

  @override
  Future<List<String>> getMovieGenres(MovieModel movie) async {
    List<String> genresList = [];
    try {
      final response = await _apiService.get(
          movieId: null,
          searchedQuery: null,
          givenEndPoint: EndPoints.movieGenre);
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
          givenEndPoint: EndPoints.movieTrailer);

      for (var dataMembers in response['results']) {
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
          givenEndPoint: EndPoints.upcomingMovies);

      for (var movie in response['results']) {
        var movieDartModel = MovieModel.fromMap(movie);
        moviesList.add(movieDartModel);
      }
      // so that we can cache the data
      moviesListGlobal = moviesList;
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
          givenEndPoint: EndPoints.movieSearch);

      for (var movie in response['results']) {
        var movieDartModel = MovieModel.fromMap(movie);
        moviesSearchedList.add(movieDartModel);
      }
    } catch (error) {
      throw InternetException(error.toString());
    }

    return moviesSearchedList;
  }

// Hive Local Storage Implementation
  void saveMoviesToHive(List<MovieModel> moviesList) {
    final box = Hive.box<MovieModel>('movies');
    if (moviesListGlobal.isNotEmpty) {
      for (var movie in moviesListGlobal) {
        movie.save(); // Hive stores it persistently!
        box.add(movie);
      }
    } else {
      throw InternetException('Need Internet first to get the movies');
    }
  }

  List<MovieModel> getMoviesFromHive() {
    final box = Hive.box<MovieModel>('movies');
    if (box.values.toList().isNotEmpty) {
      return box.values.toList().cast<MovieModel>().toList();
    } else {
      Utils.showErrorToast('You have to enable internet for the first time!');
      return [];
    }
  }
}

void main(List<String> args) {
  // Testing the Repository Layer
  // MovieRepository movieRepository = MovieRepository();
  // movieRepository.getUpcomingMovies().then((value) => print(value));
}
