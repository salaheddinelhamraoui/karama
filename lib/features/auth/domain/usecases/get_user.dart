import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.getUser();
  }
}
