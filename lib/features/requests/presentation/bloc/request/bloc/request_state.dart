part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestState {}

class LoadingRequestState extends RequestState {}

class RequestSubmittedSuccessfullyState extends RequestState {}

class ErrorLoadingTagsState extends RequestState {
  final String message;

  const ErrorLoadingTagsState({required this.message});
}
