import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String tagName;

  const Tag({required this.id, required this.tagName});

  @override
  List<Object?> get props => [tagName, tagName];
}
