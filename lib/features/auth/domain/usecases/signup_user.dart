import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class SignUpUserUseCase {
  final UserRepository repository;

  SignUpUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String mobileNumber) async {
    return await repository.signUpUser(mobileNumber);
  }
}
