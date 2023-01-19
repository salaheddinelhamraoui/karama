part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContactsEvent extends ContactsEvent {}

class InviteContactEvent extends ContactsEvent {
  String mobileNumber;
  InviteContactEvent({required this.mobileNumber});
}

class SortContactsEvent extends ContactsEvent {
  List<CustomContact> contactsFromRemote;
  List<CustomContact> contactsFromLocal;

  SortContactsEvent(
      {required this.contactsFromRemote, required this.contactsFromLocal});
}
