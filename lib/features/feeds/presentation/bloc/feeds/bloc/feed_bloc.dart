import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/feeds/domain/usecases/get_Feed.dart';

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
            message: _mapFailureToMessage(failure),
          ),
          (feeds) => FeedLoadedState(feeds: feeds),
        ));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Please try again later.';
      case EmptyCacheFailure:
        return 'No Data';
      case OfflineFailure:
        return 'Please Check your Internet Connection';
      case InvalidCredentialsFailure:
        return 'Invalid Credentials !';
      case NotInvitedFailure:
        return 'Phone Number Not Invited Or Already Exist';
      case PhoneVerificationFailure:
        return 'Unable to verify mobile phone number';
      default:
        return "Unexpected Error, Please try again later";
    }
  }
}
