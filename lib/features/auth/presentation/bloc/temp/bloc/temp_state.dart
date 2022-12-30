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

  const TempDataState({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}

class ErrorUserState extends TempState {
  final String message;

  const ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}
