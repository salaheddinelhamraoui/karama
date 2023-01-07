// class TagCategoryRepositoryImpl implements TagRepository {
//   final TagRemoteDataSource remoteDataSource;

//   TagCategoryRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<TagCategory>>> getTags() async {
//     try {
//       final data = await remoteDataSource.getTags();
//       return Right(data);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
// }

import 'package:karama/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/request.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/tag_remote_data_source.dart';

class RequestRepositoryImpl implements RequestRepository {
  final TagRemoteDataSource remoteDataSource;

  RequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> postRequest(Request req) {
    // TODO: implement postRequest
    throw UnimplementedError();
  }
}
