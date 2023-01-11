part of 'my_feed_bloc.dart';

abstract class MyFeedEvent extends Equatable {
  const MyFeedEvent();

  @override
  List<Object> get props => [];
}

class GetMyFeedEvent extends MyFeedEvent {}
