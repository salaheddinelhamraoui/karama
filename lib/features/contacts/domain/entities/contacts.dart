import 'package:equatable/equatable.dart';
import 'contact.dart';

class Contacts {
  List<CustomContact> contacts = [];
  final List<String> invitedUsers;

  Contacts({required this.contacts, required this.invitedUsers});
}
