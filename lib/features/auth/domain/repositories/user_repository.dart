import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> loginUser(String mobileNumber, String password);
  Future<Either<Failure, String>> signUpUser(String mobileNumber);
  Future<Either<Failure, String>> verifyUser(
      String pinCode, String mobileNumber);
  Future<Either<Failure, User>> setUpUser(User user);
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, String>> getCachedVerifyUserState();
  Future<Map<String, String>> getTempData();
  Future<Either<Failure, String>> submitOnboardingData(
      String avatar,
      String firstName,
      String lastName,
      String gender,
      String country,
      String state,
      String city,
      String token,
      String mobileNumber,
      String password);
  Future<Either<Failure, Unit>> editProfile(User user);
  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, Unit>> refreshToken();
}
