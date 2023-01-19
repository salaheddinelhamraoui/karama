part of 'check_contacts_bloc.dart';

abstract class CheckContactsState extends Equatable {
  const CheckContactsState();

  @override
  List<Object> get props => [];
}

class CheckContactsInitial extends CheckContactsState {}

class CheckContactsLoadingState extends CheckContactsState {}

class CheckContactsLoadedState extends CheckContactsState {
  final List<CustomContact> contacts;

  CheckContactsLoadedState({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class ErrorCheckContactsState extends CheckContactsState {
  final String message;

  ErrorCheckContactsState({required this.message});
}
