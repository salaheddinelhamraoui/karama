import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class GetTokenUseCase {
  final UserRepository repository;

  GetTokenUseCase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getToken();
  }
}
