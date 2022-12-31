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

  const TempDataState(
      {required this.mobileNumber, this.token, this.verifyState});
}

class ErrorUserState extends TempState {
  final String message;
  final String? mobileNumber;

  const ErrorUserState({required this.message, this.mobileNumber});

  @override
  List<Object> get props => [message];
}
