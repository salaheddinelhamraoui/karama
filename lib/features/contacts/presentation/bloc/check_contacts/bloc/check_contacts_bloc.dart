import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/check_contacts.dart';

part 'check_contacts_event.dart';
part 'check_contacts_state.dart';

class CheckContactsBloc extends Bloc<CheckContactsEvent, CheckContactsState> {
  final CheckContactsUseCase checkContacts;
  CheckContactsBloc({required this.checkContacts})
      : super(CheckContactsInitial()) {
    on<CheckContactsEvent>((event, emit) async {
      if (event is PostCheckContactsEvent) {
        emit(CheckContactsLoadingState());
        final failureOrDoneMessage = await checkContacts(event.contacts);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorCheckContactsState(
            message: _mapFailureToMessage(failure),
          ),
          (contacts) => CheckContactsLoadedState(contacts: contacts),
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
