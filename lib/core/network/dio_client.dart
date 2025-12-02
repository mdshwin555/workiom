import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_routes.dart';

class DioClient {
  DioClient._();

  static final Dio _dio = () {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('⏩ REQUEST [${options.method}] => ${options.uri}');
            print('Headers: ${options.headers}');
            print('Data: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print(
                '✅ RESPONSE [${response.statusCode}] => ${response.requestOptions.uri}');
            print('Data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print(
                '❌ ERROR [${e.response?.statusCode}] => ${e.requestOptions.uri}');
            print('Message: ${e.message}');
            print('Data: ${e.response?.data}');
          }
          handler.next(e);
        },
      ),
    );

    return dio;
  }();

  static Dio get instance => _dio;

  static Future<Response<T>> getRequest<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  static Future<Response<T>> postRequest<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
