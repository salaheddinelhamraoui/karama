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
