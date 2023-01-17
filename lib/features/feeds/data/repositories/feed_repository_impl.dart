import 'package:karama/features/feeds/domain/entities/feed.dart';

import 'package:karama/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Feed>>> getFeeds() async {
    try {
      final data = await remoteDataSource.getFeeds();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Feed>>> getFeedByUser() async {
    try {
      final data = await remoteDataSource.getFeedByUser();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
