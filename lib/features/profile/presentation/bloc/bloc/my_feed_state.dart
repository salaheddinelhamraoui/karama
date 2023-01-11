part of 'my_feed_bloc.dart';

abstract class MyFeedState extends Equatable {
  const MyFeedState();

  @override
  List<Object> get props => [];
}

class MyFeedInitial extends MyFeedState {}

class LoadingMyFeedState extends MyFeedState {}

class MyFeedLoaded extends MyFeedState {
  final List<Feed> feeds;

  MyFeedLoaded({required this.feeds});

  @override
  List<Object> get props => [feeds];
}

class ErrorMyFeedState extends MyFeedState {
  final String message;

  const ErrorMyFeedState({required this.message});
}
