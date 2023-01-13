import 'package:dartz/dartz.dart';
import 'package:karama/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/contact.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase(this.repository);

  Future<Either<Failure, List<CustomContact>>> call() async {
    return await repository.getContacts();
  }
}
