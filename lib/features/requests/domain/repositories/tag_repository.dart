import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';

import '../entities/tag_category.dart';

abstract class TagRepository {
  Future<Either<Failure, List<TagCategory>>> getTags(String token);
}
