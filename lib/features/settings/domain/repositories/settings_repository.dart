import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> delete();
}
