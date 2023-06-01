import 'package:filmfinder_app/data/network/end_points.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static final String _apiKey = dotenv.env['api_key']!;
  static const String _baseurl = "https://api.themoviedb.org";
  static const _movieList = "/3/movie/upcoming";
  static const String _movieSearch = "/3/search/movie";
  static const String _movieGenre = "/3/genre/movie/list";
  static const String _pageNo = "1";
// using String interpolation to Make the Url work Dynamically
// Everytime we need to make a network call we will call this method
  static String dynamicUrlMaker(
      {String? searchedQuery, required endPoints selectedEndPoint}) {
    switch (selectedEndPoint) {
      case endPoints.movieList:
        return "$_baseurl$_movieList?api_key=$_apiKey&language=en-US&page=$_pageNo";
      case endPoints.movieSearch:
        return "$_baseurl$_movieSearch?query=$searchedQuery&include_adult=false&language=en-US&page=$_pageNo";
      case endPoints.movieGenre:
        return "$_baseurl$_movieGenre?api_key=$_apiKey&language=en";
      default:
        return "$_baseurl$_movieList?api_key=$_apiKey&language=en-US&page=$_pageNo";
    }
  }
}

//! This class will define all the URLs used in the app for network calls


//! From Where Do I got this info?
//! Api Documentation
// https://developer.themoviedb.org/reference/