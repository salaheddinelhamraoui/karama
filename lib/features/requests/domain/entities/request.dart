import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/entities/tag.dart';

class Request extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String products;
  final String services;
  final String pereference;
  final List<Tag> tags;
  final String area;
  final bool closed;

  Request({
    this.id,
    required this.title,
    required this.description,
    required this.products,
    required this.services,
    required this.pereference,
    required this.tags,
    required this.area,
    required this.closed,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}
