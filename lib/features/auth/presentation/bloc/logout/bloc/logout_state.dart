part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LoggingOutState extends LogoutState {}

class LoggedOutState extends LogoutState {}

class LoggingErrorState extends LogoutState {
  final String message;

  const LoggingErrorState({required this.message});
}
