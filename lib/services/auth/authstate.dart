import 'package:openapi/openapi.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String token;
  final UserBase? user;
  Authenticated(this.token, this.user);
}

class Unauthenticated extends AuthState {
  final String? error;
  Unauthenticated({this.error});
}
