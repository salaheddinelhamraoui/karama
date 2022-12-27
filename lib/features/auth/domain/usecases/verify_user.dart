import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class VerifyUserUseCase {
  final UserRepository repository;

  VerifyUserUseCase(this.repository);

  Future<Either<Failure, String>> call(String pinCode) async {
    return await repository.verifyUser(pinCode);
  }
}
