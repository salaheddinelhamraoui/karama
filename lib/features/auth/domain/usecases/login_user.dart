import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> call(String mobileNumber) async {
    return await repository.loginUser(mobileNumber);
  }
}
