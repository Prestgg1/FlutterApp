abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String token;
  Authenticated(this.token);
}

class Unauthenticated extends AuthState {
  final String? error;
  Unauthenticated({this.error});
}
