part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestState {}

class LoadingRequestState extends RequestState {}

class RequestSubmittedSuccessfullyState extends RequestState {}

class ErrorRequestState extends RequestState {
  final String message;

  const ErrorRequestState({required this.message});
}
