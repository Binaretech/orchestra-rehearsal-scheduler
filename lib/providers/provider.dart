import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'provider.g.dart';

const String baseUrl = 'http://localhost:8080';
const String contentTypeHeader = 'application/json';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': contentTypeHeader,
      },
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final sharedPrefs = await SharedPreferences.getInstance();

      final token = sharedPrefs.getString('accessToken');

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (DioException error, handler) {
      if (error.response?.statusCode == 401) {
        // Handle unauthorized (e.g., refresh token or logout)
      }
      return handler.next(error);
    },
  ));

  return dio;
}
