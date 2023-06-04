import 'dart:convert';
import 'dart:io';
import 'package:filmfinder_app/data/exceptions/app_exceptions.dart';
import 'package:filmfinder_app/data/network/api_urls.dart';
import 'package:filmfinder_app/data/network/base_api_services.dart';
import 'package:filmfinder_app/data/network/end_points.dart';
import 'package:http/http.dart' as http;

class ApiService extends BaseApiServices {
  // GET REQUEST
  @override
  Future<dynamic> get(
      {String? movieId,
      String? searchedQuery,
      required EndPoints givenEndPoint}) async {
    final String url;
    if (searchedQuery != null) {
      url = ApiUrls.dynamicUrlMaker(
          searchedQuery: searchedQuery, selectedEndPoint: givenEndPoint);
    } else if (movieId != null) {
      url = ApiUrls.dynamicUrlMaker(
          movieId: movieId, selectedEndPoint: givenEndPoint);
    } else {
      url = ApiUrls.dynamicUrlMaker(selectedEndPoint: givenEndPoint);
    }

    dynamic response;
    try {
      response = await http.get(Uri.parse(url));
      response = responseStatusHandler(response);
      return response;
    } on SocketException {
      throw InternetException("No Internet 😔");
    }
  }

//! This Method is used to handle the different type of responses from the server
// By Reading the Api Documentation
// We can better handle the different types of status codes we receive!

  dynamic responseStatusHandler(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // 200 -> OK: it means we got the response so we will return it
        return jsonDecode(response.body);
      case 201:
        // 201 -> Created: A new resource was created
        return "new Resource Created";
      case 400:
        // 400 -> Bad Request: it means the request was invalid or cannot be served. An accompanying error message will explain further.
        throw BadRequestException(
            "Invalid page: Pages start at 1 and max at 1000. They are expected to be an integer.");
      case 401:
        return "invalid Api Key";
      default:
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}

// void main(List<String> args) {
//   // Testing purposes
// }
