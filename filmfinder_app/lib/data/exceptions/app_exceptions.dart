//* Exception classes for handling different types of exceptions

class AppExceptions implements Exception {
  final String? _prefix, _message;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

//* Now every Exception class will extend this AppExceptions class

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, "no Internet");
}

class ServerTimeOut extends AppExceptions {
  ServerTimeOut([String? message]) : super(message, "server Timeout");

}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message, "Bad Request Exception");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message])
      : super(message, "Invalid input Exception Exception");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, "Unauthorized Exception");
}


// Accordingly other exception classes can be made here