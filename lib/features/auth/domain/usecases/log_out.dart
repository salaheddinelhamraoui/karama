import 'package:dartz/dartz.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

class LogOutUseCase {
  final UserRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.logOut();
  }
}
