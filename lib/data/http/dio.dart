import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_test_task/data/constant/app_url.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: const Duration(milliseconds: 20000),
  ),
);

void initDio() {
  dio.interceptors.addAll([
    LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (e) {
          log(e.toString());
        })
  ]);
}
