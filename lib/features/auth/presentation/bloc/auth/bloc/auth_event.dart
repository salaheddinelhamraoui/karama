part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class getUserEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {
  final String mobileNumber;
  final String password;

  const LogInEvent({required this.mobileNumber, required this.password});

  @override
  List<Object> get props => [mobileNumber, password];
}

class RefreshToken extends AuthEvent {
  final User user;
  final String token;

  RefreshToken({required this.user, required this.token});
}
