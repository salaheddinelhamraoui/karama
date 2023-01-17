import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/error_message.dart';
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
            message: mapFailureToMessage(failure),
          ),
          (done) => RequestEditedState(),
        ));
      }
    });
  }
}
