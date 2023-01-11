part of 'edit_request_bloc.dart';

abstract class EditRequestEvent extends Equatable {
  const EditRequestEvent();

  @override
  List<Object> get props => [];
}

class PostEditRequestEvent extends EditRequestEvent {
  final Request req;

  PostEditRequestEvent({required this.req});
}
