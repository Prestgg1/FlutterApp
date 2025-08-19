abstract class AuthEvent {}

class AuthCheck extends AuthEvent {} // App start

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  AuthLogin(this.email, this.password);
}

class AuthRegister extends AuthEvent {
  final String name;
  final String finCode;
  final String address;
  final String street;
  final String city;
  final String gender;
  final String phone;
  final String birthday;
  final String email;
  final String region;
  final String password;
  AuthRegister(
    this.name,
    this.finCode,
    this.address,
    this.street,
    this.region,
    this.city,
    this.gender,
    this.phone,
    this.birthday,
    this.email,
    this.password,
  );
}

class AuthLogout extends AuthEvent {}
