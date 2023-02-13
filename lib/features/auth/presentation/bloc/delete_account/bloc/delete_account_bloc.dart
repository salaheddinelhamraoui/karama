import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/core/error/error_message.dart';

import '../../../../domain/usecases/delete_user.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteUserUseCase deleteUser;
  DeleteAccountBloc({required this.deleteUser})
      : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) async {
      if (event is PostDeleteAccountEvent) {
        emit(DeleteAccountLoading());
        final failureOrDoneMessage = await deleteUser();
        emit(failureOrDoneMessage.fold(
          (failure) =>
              DeleteAccountError(message: mapFailureToMessage(failure)),
          (unit) => DeleteAccountSuccess(),
        ));
      }
    });
  }
}
