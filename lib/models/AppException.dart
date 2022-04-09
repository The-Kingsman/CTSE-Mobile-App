class AppException implements Exception {
  final _message;

  AppException([this._message]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super('Seems like our shop is offline. Try again later');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message);
}
