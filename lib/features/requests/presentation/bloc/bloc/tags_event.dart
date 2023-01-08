part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class GetTagsEvent extends TagsEvent {
  const GetTagsEvent();

  @override
  List<Object> get props => [];
}
