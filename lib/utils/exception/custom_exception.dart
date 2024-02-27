import 'package:http/http.dart';

class CustomException implements Exception{
  String message;

  CustomException(this.message);
}

