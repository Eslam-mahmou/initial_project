import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:initial_project/core/service/shared_pref_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constant_manager.dart';




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

@lazySingleton
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = SharedPrefHelper.getSecureString(AppConstants.token);
    final lang = SharedPrefHelper.getString('languageCode') ?? 'en';
    options.headers["Authorization"] = "Bearer $token";

    options.headers["Accept-Language"] = lang;

    return handler.next(options);
  }
}
