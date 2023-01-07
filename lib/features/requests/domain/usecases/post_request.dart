import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/request.dart';
import '../repositories/request_repository.dart';

class PostRequestUseCase {
  final RequestRepository repository;

  PostRequestUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Request req) async {
    return await repository.postRequest(req);
  }
}
