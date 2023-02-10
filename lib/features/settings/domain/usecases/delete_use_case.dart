import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/settings_repository.dart';

class DeleteUseCase {
  final SettingsRepository repository;

  DeleteUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.delete();
  }
}
