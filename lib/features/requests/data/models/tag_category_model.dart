import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_category.dart';

class TagCategoryModel extends TagCategory {
  const TagCategoryModel(
      {required int id,
      required String name,
      required String type,
      required List<Tag> tags})
      : super(id: id, name: name, type: type, tags: tags);

  @override
  List<Object?> get props => [id, name, type, tags];
}
