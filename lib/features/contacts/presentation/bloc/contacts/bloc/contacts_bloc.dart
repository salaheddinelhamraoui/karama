import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/contacts/domain/usecases/check_contacts.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/entities/contact.dart';
import '../../../../domain/usecases/get_contacts.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContactsUseCase getContacts;

  ContactsBloc({required this.getContacts}) : super(ContactsInitial()) {
    on<ContactsEvent>((event, emit) async {
      if (event is GetContactsEvent) {
        emit(LoadingContactsState());
        print('hola');
        final failureOrDoneMessage = await getContacts();

        print('s');
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingContactsState(
            message: _mapFailureToMessage(failure),
          ),
          (contacts) => ContactsLoadedState(contacts: contacts),
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
