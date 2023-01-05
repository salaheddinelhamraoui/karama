part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class getTagsEvent extends TagsEvent {
  const getTagsEvent();

  @override
  List<Object> get props => [];
}
