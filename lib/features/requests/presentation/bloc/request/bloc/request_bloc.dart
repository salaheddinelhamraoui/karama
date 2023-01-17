import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/error_message.dart';
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
          (failure) => ErrorRequestState(
            message: mapFailureToMessage(failure),
          ),
          (done) => RequestSubmittedSuccessfullyState(),
        ));
      }
    });
  }
}
