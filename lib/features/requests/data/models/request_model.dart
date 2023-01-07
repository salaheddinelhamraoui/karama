// class TagCategoryModel extends TagCategory {
//   const TagCategoryModel(
//       {required int id,
//       required String name,
//       required int type,
//       required List<Tag> tags})
//       : super(id: id, name: name, type: type, tags: tags);

//   @override
//   List<Object?> get props => [id, name, type, tags];
// }

import '../../domain/entities/request.dart';

class RequestModel extends Request {
  RequestModel(
      {required super.title,
      required super.description,
      required super.products,
      required super.services,
      required super.pereference,
      required super.tags,
      required super.area,
      required super.token});
}
