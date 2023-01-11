import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../feeds/domain/entities/feed.dart';
import '../../../../domain/entities/request.dart';
import '../../../../domain/usecases/edit_request.dart';

part 'edit_request_event.dart';
part 'edit_request_state.dart';

class EditRequestBloc extends Bloc<EditRequestEvent, EditRequestState> {
  final EditRequestUseCase editRequest;

  EditRequestBloc({required this.editRequest}) : super(EditRequestInitial()) {
    on<EditRequestEvent>((event, emit) async {
      if (event is PostEditRequestEvent) {
        emit(EditingRequestState());
        final failureOrDoneMessage = await editRequest(event.req);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorEditingRequestState(
            message: _mapFailureToMessage(failure),
          ),
          (done) => RequestEditedState(),
        ));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Something went wrong, pleases try again later.';
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
