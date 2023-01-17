import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/feeds/domain/usecases/get_Feed.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/entities/feed.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedsUseCase getFeeds;

  FeedBloc({required this.getFeeds}) : super(FeedInitial()) {
    on<FeedEvent>((event, emit) async {
      if (event is GetFeedsEvent) {
        emit(FeedLoadingState());
        final failureOrDoneMessage = await getFeeds();
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingFeedsState(
            message: mapFailureToMessage(failure),
          ),
          (feeds) => FeedLoadedState(feeds: feeds),
        ));
      }
    });
  }
}
