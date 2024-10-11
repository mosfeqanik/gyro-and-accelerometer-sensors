import 'package:dio/dio.dart';

import '../../../core/data/dio/dio_client.dart';
import '../../../core/data/exception/api_error_handler.dart';
import '../../../core/data/model/api_response.dart';
import '../../../utils/api_end_points.dart';

class DashBoardRepo {
  late DioClient? dioClient;

  DashBoardRepo(this.dioClient);

  Future<ApiResponse> getLotDetails({
    String? productId,
    String? orgParams,
    String? isAllOn,
  }) async {
    try {
      var product = productId == null && productId!.isEmpty
          ? ""
          : "product_id=$productId";
      Response? response = await dioClient?.get(
        "${ApiEndPoints.GET_LOT_DETAILS}?$orgParams&$product&all=$isAllOn",
      );
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> rmgGetAvailableQuantity(
      {String? orgType, String? orgID}) async {
    try {
      Response? response = await dioClient?.get(
        "${ApiEndPoints.getAvailableQuantityFunc(orgType: orgType)}/$orgID",
      );
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> ufpoGetAvailableQuantity(
      {String? orgType, String? orgID}) async {
    try {
      Response? response = await dioClient?.get(
        "${ApiEndPoints.getAvailableQuantityFunc(orgType: orgType)}/$orgID",
      );
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> rmgGetDistributionQuantity(
      {String? orgType, String? orgID}) async {
    try {
      Response? response = await dioClient?.get(
        "${ApiEndPoints.getDistrubutionQuantityFunc(orgType: orgType)}/$orgID",
      );
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> ufpoGetDistributionQuantity(
      {String? orgType, String? orgID}) async {
    try {
      Response? response = await dioClient?.get(
        "${ApiEndPoints.getDistrubutionQuantityFunc(orgType: orgType)}/$orgID",
      );
      return ApiResponse.withSuccess(response!);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
