import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/auth/authbloc.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://bimonet.com'));

  late final backend.Openapi api;

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

    api = backend.Openapi(dio: _dio);
  }
}

class ProfileCache {
  static backend.Profile? profile;
}

/* http://127.0.0.1:8000/ */

/* https://bimonet.com */
