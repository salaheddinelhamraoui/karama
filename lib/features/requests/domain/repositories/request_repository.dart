import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';

import '../entities/request.dart';

abstract class RequestRepository {
  Future<Either<Failure, Unit>> postRequest(Request req);
}
