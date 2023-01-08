import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/feed.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<Feed>>> getFeeds();
}
