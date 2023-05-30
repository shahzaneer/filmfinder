import 'dart:convert';
import 'dart:io';
import 'package:filmfinder_app/data/exceptions/app_exceptions.dart';
import 'package:filmfinder_app/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class ApiService extends BaseApiServices {
  // GET REQUEST
  @override
  Future<dynamic> get(String url) async {
    dynamic response;
    try {
      response = await http.get(Uri.parse(url));
      response = responseStatusHandler(response);
    } on SocketException {
      throw InternetException("No Internet 😔");
    }
  }

//! This Method is used to handle the different type of responses from the server
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
        throw BadRequestException(response.reasonPhrase);
      default:
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}
