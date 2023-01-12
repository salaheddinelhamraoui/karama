import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class EditProfileUseCase {
  final UserRepository repository;

  EditProfileUseCase(this.repository);

  Future<Either<Failure, Unit>> call(User user) async {
    return await repository.editProfile(user);
  }
}
