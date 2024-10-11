import 'package:dio/dio.dart';

class ApiResponse {
  final Response<dynamic>? response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response<dynamic> responseValue)
      : response = responseValue,
        error = null;
}
