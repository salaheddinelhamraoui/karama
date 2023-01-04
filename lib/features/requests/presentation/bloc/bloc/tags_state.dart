part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  const TagsState();

  @override
  List<Object> get props => [];
}

class TagsInitial extends TagsState {}

class TagsLoadingState extends TagsState {}

class TagsLoadedState extends TagsState {
  final List<TagCategory> tags;

  TagsLoadedState({required this.tags});

  @override
  List<Object> get props => [tags];
}

class ErrorLoadingTagsState extends TagsState {
  final String message;

  const ErrorLoadingTagsState({required this.message});
}
