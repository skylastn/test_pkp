
import 'package:get/get_connect/http/src/response/response.dart';

class ResponseModel{
  ResponseModel({
    required this.isError,
    required this.result,
    required this.msg,
  });

  String msg;
  bool isError;
  Response? result;
}