import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> loginUser(String mobileNumber, String password);
  Future<Either<Failure, Unit>> signUpUser(String mobileNumber);
  Future<Either<Failure, String>> verifyUser(String pinCode);
  Future<Either<Failure, User>> setUpUser(User user);
  Future<Either<Failure, User>> getUser();
}
