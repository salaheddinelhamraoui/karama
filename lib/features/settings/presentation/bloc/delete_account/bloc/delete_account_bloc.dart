import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../domain/usecases/delete_use_case.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteUseCase deleteUseCase;

  DeleteAccountBloc({required this.deleteUseCase})
      : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) async {
      if (event is PostDeleteAccountEvent) {
        emit(DeleteAccountLoadingState());
        final failureOrDoneMessage = await deleteUseCase();

        emit(failureOrDoneMessage.fold(
          (failure) => ErrorDeletingAccountState(
            message: mapFailureToMessage(failure),
          ),
          (done) => DeleteAccountLoadedState(),
        ));
      }
    });
  }
}
