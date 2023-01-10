import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/entities/tag.dart';

class Feed extends Equatable {
  final int id;
  final String title;
  final String description;
  final String products;
  final String services;
  final String pereference;
  final List<Tag> tags;
  final String area;
  final int userId;
  final String firstName;
  final String lastName;
  final String avatar;
  final String phone;
  final DateTime createdDate;

  Feed(
      {required this.id,
      required this.title,
      required this.description,
      required this.products,
      required this.services,
      required this.pereference,
      required this.tags,
      required this.area,
      required this.userId,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.phone,
      required this.createdDate});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        products,
        services,
        pereference,
        tags,
        area,
        userId,
        firstName,
        lastName,
        avatar,
        phone,
        createdDate
      ];
}
