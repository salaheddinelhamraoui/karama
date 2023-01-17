import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/auth/domain/usecases/log_out.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogOutUseCase logOut;
  LogoutBloc({required this.logOut}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is PostLoginOutEvent) {
        emit(LoggingOutState());
        final failureOrDoneMessage = await logOut();
        emit(failureOrDoneMessage.fold(
          (failure) => LoggingErrorState(
            message: mapFailureToMessage(failure),
          ),
          (unit) => LoggedOutState(),
        ));
      }
    });
  }
}
