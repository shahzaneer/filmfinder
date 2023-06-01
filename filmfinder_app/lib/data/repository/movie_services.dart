import 'package:filmfinder_app/models/movie_model.dart';

abstract class MovieServices {
  Future<dynamic> getUpcomingMovies();
  Future<String> getMovieTrailer(String movieId);
  Future<dynamic> getMovieGenres(MovieModel movie);
  Future<dynamic> searchMovies(String searchedQuery);
}
