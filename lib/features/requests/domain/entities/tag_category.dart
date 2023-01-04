import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/entities/tag.dart';

class TagCategory extends Equatable {
  final int id;
  final String name;
  final String type;
  final List<Tag> tags;

  const TagCategory(
      {required this.id,
      required this.name,
      required this.type,
      required this.tags});

  @override
  List<Object?> get props => [id, name, type, tags];
}
