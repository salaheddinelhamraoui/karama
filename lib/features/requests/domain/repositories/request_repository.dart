import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';

import '../entities/request.dart';

// import '../entities/tag_category.dart';

// abstract class TagRepository {
//   Future<Either<Failure, List<TagCategory>>> getTags();
// }

abstract class RequestRepository {
  Future<Either<Failure, Unit>> postRequest(Request req);
}
