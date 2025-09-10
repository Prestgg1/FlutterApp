import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
    on<AuthUpdateUserImage>(_onAuthUpdateUserImage);
    on<AuthRegister>(_onAuthRegister);
  }
  _onAuthUpdateUserImage(AuthUpdateUserImage event, Emitter<AuthState> emit) {
    final currentState = state;
    if (currentState is Authenticated && currentState.user != null) {
      final updatedUser = backend.UserBase(
        (b) => b
          ..id = currentState.user!.id
          ..name = currentState.user!.name
          ..email = currentState.user!.email
          ..role = currentState.user!.role
          ..status = currentState.user!.status
          ..image = event.image,
      );
      emit(Authenticated(currentState.token, updatedUser));
    }
  }

  Future<void> _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    final currentState = state;

    // Əgər artıq user məlumatı state-də varsa təkrar api çağırmaya ehtiyac yoxdur
    if (currentState is Authenticated && currentState.user != null) {
      emit(currentState);
      return;
    }

    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      _api.dio.options.headers['Authorization'] = 'Bearer $token';

      try {
        final response = await _api.getAuthApi().meApiAuthMeGet();
        final userBase =
            response.data?.anyOf.values.entries.first.value
                as backend.UserBase?;

        emit(Authenticated(token, userBase));
      } catch (e) {
        emit(Unauthenticated(error: "Profil məlumatı alına bilmədi"));
      }
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

        emit(Authenticated(result.data!.token, result.data?.user));
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
            ..region = event.region
            ..city = event.city
            ..gender = event.gender == "Kişi"
                ? backend.GenderEnumSchema.male
                : backend.GenderEnumSchema.female
            ..phone = event.phone
            ..birthday = backend.Date(
              event.birthday.year,
              event.birthday.month,
              event.birthday.day,
            )
            ..email = event.email
            ..password = event.password,
        ),
      );
      debugPrint(result.toString());
      if (result.statusCode == 200 && result.data != null) {
        await _storage.write(key: 'access_token', value: result.data!.token);
        _api.dio.options.headers['Authorization'] =
            'Bearer ${result.data!.token}';

        emit(Authenticated(result.data!.token, result.data?.user));
      } else {
        emit(Unauthenticated(error: 'Email və ya şifrə yanlışdır'));
      }
    } catch (e) {
      debugPrint(e.toString());
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

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await _storage.delete(key: 'access_token');
    emit(Unauthenticated());
  }
}
