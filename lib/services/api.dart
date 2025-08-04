import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Openapi api;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    api = Openapi(dio: Dio(BaseOptions(baseUrl: 'https://bimonet.com')));
  }
}
/* http://127.0.0.1:8000/ */

/* https://bimonet.com */
