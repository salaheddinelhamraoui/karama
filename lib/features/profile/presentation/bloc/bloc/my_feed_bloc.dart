import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/feeds/domain/usecases/get_Feed_By_User.dart';

import '../../../../../core/error/failure.dart';
import '../../../../feeds/domain/entities/feed.dart';
import '../../../../requests/domain/entities/request.dart';

part 'my_feed_event.dart';
part 'my_feed_state.dart';

class MyFeedBloc extends Bloc<MyFeedEvent, MyFeedState> {
  final GetFeedByUserUseCase getMyFeed;
  MyFeedBloc({required this.getMyFeed}) : super(MyFeedInitial()) {
    on<MyFeedEvent>((event, emit) async {
      if (event is GetMyFeedEvent) {
        emit(LoadingMyFeedState());
        final failureOrDoneMessage = await getMyFeed();
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorMyFeedState(
            message: _mapFailureToMessage(failure),
          ),
          (feeds) => MyFeedLoaded(feeds: feeds),
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
