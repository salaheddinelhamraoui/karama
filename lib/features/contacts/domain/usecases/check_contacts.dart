import 'package:dartz/dartz.dart';
import 'package:karama/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/error/failure.dart';

class CheckContactsUseCase {
  final ContactRepository repository;

  CheckContactsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call(List<String> contacts) async {
    return await repository.checkContacts(contacts);
  }
}
