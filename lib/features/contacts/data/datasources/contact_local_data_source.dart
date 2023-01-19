import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:karama/core/error/exceptions.dart';

import '../../domain/entities/contact.dart';

abstract class ContactLocalDataSource {
  Future<List<CustomContact>> getContacts();
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  @override
  Future<List<CustomContact>> getContacts() async {
    try {
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: false);
      }

      List<CustomContact> customContacts = [];

      for (var i = 0; i < contacts.length; i++) {
        if (contacts[i].phones.length > 0) {
          customContacts.add(CustomContact(
              contactName: '${contacts[i].name.last} ${contacts[i].name.first}',
              contactNumber: contacts[i].phones[0].normalizedNumber,
              invited: false));
        }
      }

      return Future.value(customContacts);
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
