part of 'temp_bloc.dart';

abstract class TempEvent extends Equatable {
  const TempEvent();

  @override
  List<Object> get props => [];
}

class StoreMobileNumberEvent extends TempEvent {
  final String mobileNumber;

  const StoreMobileNumberEvent({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}

class SignUpEvent extends TempEvent {
  final String mobileNumber;

  const SignUpEvent({required this.mobileNumber});

  @override
  List<Object> get props => [mobileNumber];
}

class VerifyUserEvent extends TempEvent {
  final String mobileNumber;
  final String pinCode;

  VerifyUserEvent({required this.mobileNumber, required this.pinCode});

  @override
  List<Object> get props => [mobileNumber, pinCode];
}

class ChoosePasswordEvent extends TempEvent {
  final String mobileNumber;
  final String token;
  final String password;

  ChoosePasswordEvent(
      {required this.mobileNumber,
      required this.password,
      required this.token});
}

class GetTempDataEvent extends TempEvent {}
