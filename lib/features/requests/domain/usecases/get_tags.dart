import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/tag_category.dart';
import '../repositories/tag_repository.dart';

class GetTagsUseCase {
  final TagRepository repository;

  GetTagsUseCase(this.repository);

  Future<Either<Failure, List<TagCategory>>> call(String token) async {
    return await repository.getTags(token);
  }
}
