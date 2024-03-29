import 'dart:developer';

import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, User>> loginUser(
      String mobileNumber, String password) async {
    try {
      final user = await remoteDataSource.sinIn(mobileNumber, password);
      localDataSource.cacheUser(user);
      return Right(user);
    } on ServerException {
      return Left(InvalidCredentialsFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      // await remoteDataSource.refreshToken();
      final token = await localDataSource.getCachedToken();
      return Right(token);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCachedVerifyUserState() async {
    try {
      final state = await localDataSource.getCachedVerifyUserState();
      return Right(state);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> signUpUser(String mobileNumber) async {
    try {
      final data = await remoteDataSource.signUp(mobileNumber);
      return Right(mobileNumber);
    } on ServerException {
      return Left(NotInvitedFailure());
    }
  }

  @override
  Future<Either<Failure, String>> verifyUser(
      String pinCode, String mobileNumber) async {
    try {
      final token = await remoteDataSource.verifyUser(pinCode, mobileNumber);
      return Right(token);
    } on ServerException {
      return Left(PhoneVerificationFailure());
    }
  }

  @override
  Future<Either<Failure, User>> setUpUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> getTempData() async {
    return await localDataSource.getTempData();
  }

  @override
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
      String password) async {
    try {
      final result = await remoteDataSource.submitOnboardingData(
          avatar,
          firstName,
          lastName,
          gender,
          country,
          state,
          city,
          token,
          mobileNumber,
          password);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editProfile(User user) async {
    try {
      final data = await remoteDataSource.editProfile(user);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      return Right(await localDataSource.logOut());
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> refreshToken() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    try {
      final data = await remoteDataSource.deleteUser();
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
