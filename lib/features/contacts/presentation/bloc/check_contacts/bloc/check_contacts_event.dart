part of 'check_contacts_bloc.dart';

abstract class CheckContactsEvent extends Equatable {
  const CheckContactsEvent();

  @override
  List<Object> get props => [];
}

class PostCheckContactsEvent extends CheckContactsEvent {
  final List<String> contacts;
  PostCheckContactsEvent({required this.contacts});
}
