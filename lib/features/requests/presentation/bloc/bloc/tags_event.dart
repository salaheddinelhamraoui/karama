part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class getTagsEvent extends TagsEvent {
  final String token;

  const getTagsEvent({required this.token});

  @override
  List<Object> get props => [token];
}
