import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RefreshTokenUseCase {
  final UserRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.refreshToken();
  }
}
