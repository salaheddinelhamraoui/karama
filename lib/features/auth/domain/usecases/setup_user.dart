import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class SetUpUserUseCase {
  final UserRepository repository;

  SetUpUserUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.setUpUser(user);
  }
}
