import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';




@module
abstract class DioProvider {
  @lazySingleton
  Dio dioProvider() {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    dio.interceptors.add(providePretty());
    // dio.interceptors.add(AuthInterceptor()); //add it here
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePretty() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    );
  }
}

// @lazySingleton
// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options,
//       RequestInterceptorHandler handler,
//       ) async {
//     final token = SharedPreferenceServices.getData(AppConstants.token);
//     // final lang = SharedPreferenceServices.getData(AppConstants.language) ?? 'en';
//     final lang = SharedPreferenceServices.getData('languageCode') ?? 'en';
//     if (token != null) {
//       options.headers["Authorization"] = "Bearer $token";
//     }
//
//     options.headers["Accept-Language"] = lang;
//
//     return handler.next(options);
//   }
// }
