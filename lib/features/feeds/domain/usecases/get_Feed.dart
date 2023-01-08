import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/feed.dart';
import '../repositories/feed_repository.dart';

class GetFeedsUseCase {
  final FeedRepository repository;

  GetFeedsUseCase(this.repository);

  Future<Either<Failure, List<Feed>>> call() async {
    return await repository.getFeeds();
  }
}
