import 'package:filmfinder_app/data/network/end_points.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static final String _apiKey = dotenv.env['api_key']!;
  static const String baseurl = "https://api.themoviedb.org";
  static const _movieList = "/3/movie/upcoming";
  static const String _movieSearch = "/3/search/movie";
  static const String _movieGenre = "/3/genre/movie/list";
  static const String _pageNo = "1";
// using String interpolation to Make the Url work Dynamically
// Everytime we need to make a network call we will call this method
  static String dynamicUrlMaker(
      {String? searchedQuery,
      String? movieId,
      required EndPoints selectedEndPoint}) {
    switch (selectedEndPoint) {
      case EndPoints.movieList:
        return "$baseurl$_movieList?api_key=$_apiKey&language=en-US&page=$_pageNo";
      case EndPoints.movieSearch:
        return "$baseurl$_movieSearch?api_key=$_apiKey&query=$searchedQuery&include_adult=false&language=en-US&page=$_pageNo";
      case EndPoints.movieGenre:
        return "$baseurl$_movieGenre?api_key=$_apiKey&language=en";
      case EndPoints.movieTrailer:
        return "$baseurl/3/movie/$movieId/videos?api_key=$_apiKey&language=en-US";
      default:
        return "$baseurl$_movieList?api_key=$_apiKey&language=en-US&page=$_pageNo";
    }
  }
}

//! This class will define all the URLs used in the app for network calls


//! From Where Do I got this info?
//! Api Documentation
// https://developer.themoviedb.org/reference/