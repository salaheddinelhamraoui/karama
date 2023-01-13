import 'package:flutter_contacts/flutter_contacts.dart';

import '../../domain/entities/contact.dart';

abstract class ContactLocalDataSource {
  Future<List<CustomContact>> getContacts();
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  @override
  Future<List<CustomContact>> getContacts() async {
    List<Contact> contacts = [];
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);
    }

    List<CustomContact> customContacts = [];

    for (var i = 0; i < contacts.length; i++) {
      customContacts.add(CustomContact(
          contactName: '${contacts[i].name.last} ${contacts[i].name.first}',
          contactNumber: contacts[i].phones[0].normalizedNumber));
    }

    return Future.value(customContacts);
  }
}
