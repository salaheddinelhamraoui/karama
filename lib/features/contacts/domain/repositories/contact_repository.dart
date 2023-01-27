import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/contact.dart';
import '../entities/contacts.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<CustomContact>>> getContacts();
  Future<Either<Failure, Contacts>> checkContacts(List<String> contacts);
  Future<Either<Failure, Unit>> inviteContact(String mobileNumber);
}
