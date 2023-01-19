import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/contact_repository.dart';

class InviteContactUseCase {
  final ContactRepository repository;

  InviteContactUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String mobileNumber) async {
    return await repository.inviteContact(mobileNumber);
  }
}
