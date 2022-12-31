import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class GetTempDataUseCase {
  final UserRepository repository;

  GetTempDataUseCase(this.repository);

  Future<Map<String, String>> call() async {
    return await repository.getTempData();
  }
}
