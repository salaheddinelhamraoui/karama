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
      return Left(ServerFailure());
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
  Future<Either<Failure, User>> setUpUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signUpUser(String mobileNumber) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> verifyUser(String pinCode) {
    throw UnimplementedError();
  }
}
