part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class SubmitRequestEvent extends RequestEvent {
  final Request req;

  SubmitRequestEvent({required this.req});
}
