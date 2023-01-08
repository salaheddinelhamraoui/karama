part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedLoadedState extends FeedState {
  final List<Feed> feeds;

  FeedLoadedState({required this.feeds});

  @override
  List<Object> get props => [feeds];
}

class ErrorLoadingFeedsState extends FeedState {
  final String message;

  const ErrorLoadingFeedsState({required this.message});
}
