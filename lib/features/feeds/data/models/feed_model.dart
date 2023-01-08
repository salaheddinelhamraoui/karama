import '../../domain/entities/feed.dart';

class FeedModel extends Feed {
  FeedModel(
      {required super.title,
      required super.description,
      required super.products,
      required super.services,
      required super.pereference,
      required super.tags,
      required super.area,
      required super.userId,
      required super.firstName,
      required super.lastName,
      required super.avatar,
      required super.phone,
      required super.createdDate});
}
