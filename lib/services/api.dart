import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://bimonet.com'));

  late final Openapi api;

  factory ApiService() {
    return _instance;
  }
  ApiService._internal() {
    // Request/response loglarını ekle
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );

    api = Openapi(dio: _dio);
  }
}

/* http://127.0.0.1:8000/ */

/* https://bimonet.com */
