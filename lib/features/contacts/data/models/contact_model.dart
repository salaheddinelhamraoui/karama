import '../../domain/entities/contact.dart';

class ContactModel extends CustomContact {
  ContactModel(
      {required super.contactName,
      required super.contactNumber,
      required super.invited,
      required super.invitationSent});
}
