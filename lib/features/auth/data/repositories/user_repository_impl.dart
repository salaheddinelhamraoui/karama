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
}
