import 'package:equatable/equatable.dart';

class CustomContact extends Equatable {
  final String contactName;
  final String contactNumber;
  final String? avatar;
  bool invited = false;
  bool invitationSent = false;

  CustomContact(
      {required this.contactName,
      required this.contactNumber,
      this.avatar,
      required this.invited,
      required this.invitationSent});

  @override
  List<Object?> get props => [contactName, contactNumber];
}
