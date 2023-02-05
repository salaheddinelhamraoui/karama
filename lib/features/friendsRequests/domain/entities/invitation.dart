import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/entities/tag.dart';

class Invitation extends Equatable {
  final String id;
  final String request_id;
  final String phone;
  final String sender_id;
  final String first_name;
  final String last_name;
  final String avatar;

  Invitation({
    required this.id,
    required this.request_id,
    required this.phone,
    required this.sender_id,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
