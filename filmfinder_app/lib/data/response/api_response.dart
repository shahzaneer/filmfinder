import 'package:filmfinder_app/data/response/status.dart';

class ApiResponse<T> {
  late Status status;
  String? message;
  T? data;
  // T is generic type as it can vary

  //! Constructor
  ApiResponse(this.status, this.message, this.data);

  // ! Named Constructors with initializer list for specific cases of responses
  // no use of message and data as it is loading state
  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

//! To print the response information
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

//! Haven't used this class anywhere in the app yet to avoid complexity!
//! However, it is a good practice to have your custom response object class in the project
//! I have used the default response object class provided by the http package