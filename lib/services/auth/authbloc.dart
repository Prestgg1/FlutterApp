import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';
import 'package:dio/dio.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _storage = const FlutterSecureStorage();
  final _api = ApiService().api;

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheck>(_onAuthCheck);
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
    on<AuthRegister>(_onAuthRegister);
  }

  Future<void> _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      _api.dio.options.headers['Authorization'] = 'Bearer $token';
      emit(Authenticated(token));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      final result = await _api.getAuthApi().loginApiAuthLoginPost(
        userLogin: backend.UserLogin(
          (b) => b
            ..email = event.email
            ..password = event.password,
        ),
      );

      if (result.statusCode == 200 && result.data != null) {
        await _storage.write(key: 'access_token', value: result.data!.token);
        _api.dio.options.headers['Authorization'] =
            'Bearer ${result.data!.token}';

        emit(Authenticated(result.data!.token));
      } else {
        emit(Unauthenticated(error: 'Email və ya şifrə yanlışdır'));
      }
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        final message = (errorData is Map && errorData['detail'] != null)
            ? errorData['detail']
            : 'Server xətası baş verdi';
        emit(Unauthenticated(error: message));
      } else {
        emit(Unauthenticated(error: 'Naməlum xəta: ${e.toString()}'));
      }
    }
  }

  Future<void> _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final result = await _api.getAuthApi().registerApiAuthRegisterPost(
        userCreate: backend.UserCreate(
          (b) => b
            ..name = event.name
            ..finCode = event.finCode
            ..address = event.address
            ..street = event.street
            ..city = event.city
            ..gender = event.gender
            ..phone = event.phone
            ..birthday = DateTime.parse(event.birthday) as backend.Date?
            ..email = event.email
            ..password = event.password,
        ),
      );
      if (result.statusCode == 200 && result.data != null) {
        await _storage.write(key: 'access_token', value: result.data!.token);
        _api.dio.options.headers['Authorization'] =
            'Bearer ${result.data!.token}';

        emit(Authenticated(result.data!.token));
      } else {
        emit(Unauthenticated(error: 'Email və ya şifrə yanlışdır'));
      }
    } catch (e) {
      emit(Unauthenticated(error: 'Server xətası'));
    }
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await _storage.delete(key: 'access_token');
    emit(Unauthenticated());
  }
}
