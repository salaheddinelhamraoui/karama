import 'package:karama/features/requests/domain/entities/tag_category.dart';

import 'package:karama/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/tag_repository.dart';
import '../datasources/tag_remote_data_source.dart';

class TagCategoryRepositoryImpl implements TagRepository {
  final TagRemoteDataSource remoteDataSource;

  TagCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TagCategory>>> getTags(String token) async {
    try {
      final data = await remoteDataSource.getTags(token);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
