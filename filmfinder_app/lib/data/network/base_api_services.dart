import 'end_points.dart';

abstract class BaseApiServices {
  Future<dynamic> get({String? movieId, String? searchedQuery,
      required EndPoints givenEndPoint});
  // Future<dynamic> post(String url, dynamic body);
  //Future<dynamic> put(String url, dynamic body);
  //Future<dynamic> delete(String url);
}

// This is the base class for all the api services
// the methods will be implemented by the respective api services
