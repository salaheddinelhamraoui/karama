import 'package:karama/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:karama/features/settings/data/datasources/settings_remote_data_source.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryIml implements SettingsRepository {
  final SettingsDataSourceImpl remoteDataSource;

  SettingsRepositoryIml({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> delete() async {
    try {
      final data = await remoteDataSource.delete();
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
