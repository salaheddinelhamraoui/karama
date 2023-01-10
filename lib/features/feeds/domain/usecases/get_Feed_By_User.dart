// class GetFeedsUseCase {
//   final FeedRepository repository;

//   GetFeedsUseCase(this.repository);

//   Future<Either<Failure, List<Feed>>> call() async {
//     return await repository.getFeeds();
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:karama/features/feeds/domain/repositories/feed_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/feed.dart';

class GetFeedByUserUseCase {
  final FeedRepository repository;

  GetFeedByUserUseCase(this.repository);

  Future<Either<Failure, List<Feed>>> call() async {
    return await repository.getFeedByUser();
  }
}
