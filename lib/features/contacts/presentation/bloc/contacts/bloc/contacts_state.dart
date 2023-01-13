part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class LoadingContactsState extends ContactsState {}

class ContactsLoadedState extends ContactsState {
  final List<CustomContact> contacts;

  ContactsLoadedState({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class ErrorLoadingContactsState extends ContactsState {
  final String message;

  ErrorLoadingContactsState({required this.message});
}
