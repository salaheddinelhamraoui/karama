part of 'temp_bloc.dart';

abstract class TempState extends Equatable {
  const TempState();

  @override
  List<Object> get props => [];
}

class TempInitial extends TempState {}

class LoadingTempState extends TempState {}

class TempDataState extends TempState {
  final String mobileNumber;
  final String? token;
  final bool? verifyState;
  final String? password;

  const TempDataState(
      {required this.mobileNumber,
      this.token,
      this.verifyState,
      this.password});
}

class SignUpDoneState extends TempState {}

class ErrorTempState extends TempState {
  final String message;
  final String? mobileNumber;
  final String? token;
  final String? password;

  const ErrorTempState(
      {required this.message, this.mobileNumber, this.token, this.password});

  @override
  List<Object> get props => [message];
}
