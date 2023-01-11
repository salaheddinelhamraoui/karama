import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../../feeds/domain/entities/feed.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class EditRequestUseCase {
  final RequestRepository repository;

  EditRequestUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Request req) async {
    return await repository.editRequest(req);
  }
}
