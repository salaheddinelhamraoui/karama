import 'package:karama/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:karama/features/feeds/domain/entities/feed.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/request.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/tag_remote_data_source.dart';

class RequestRepositoryImpl implements RequestRepository {
  final TagRemoteDataSource remoteDataSource;

  RequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> postRequest(Request req) async {
    try {
      final data = await remoteDataSource.postRequest(req);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editRequest(Request req) async {
    try {
      final data = await remoteDataSource.editRequest(req);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
