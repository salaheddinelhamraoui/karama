part of 'edit_request_bloc.dart';

abstract class EditRequestState extends Equatable {
  const EditRequestState();

  @override
  List<Object> get props => [];
}

class EditRequestInitial extends EditRequestState {}

class EditingRequestState extends EditRequestState {}

class RequestEditedState extends EditRequestState {}

class ErrorEditingRequestState extends EditRequestState {
  final String message;

  const ErrorEditingRequestState({required this.message});
}
