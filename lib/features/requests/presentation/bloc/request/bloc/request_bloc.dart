import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/entities/request.dart';
import '../../../../domain/usecases/post_request.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final PostRequestUseCase postRequest;

  RequestBloc({required this.postRequest}) : super(RequestInitial()) {
    on<RequestEvent>((event, emit) async {
      if (event is SubmitRequestEvent) {
        emit(LoadingRequestState());
        final failureOrDoneMessage = await postRequest(event.req);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingTagsState(
            message: _mapFailureToMessage(failure),
          ),
          (done) => RequestSubmittedSuccessfullyState(),
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
