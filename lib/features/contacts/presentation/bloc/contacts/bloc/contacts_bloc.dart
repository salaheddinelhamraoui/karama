import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/contacts/domain/usecases/check_contacts.dart';

import '../../../../../../core/error/error_message.dart';
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

        final failureOrDoneMessage = await getContacts();

        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingContactsState(
            message: mapFailureToMessage(failure),
          ),
          (contacts) => ContactsLoadedState(contacts: contacts),
        ));
      }
    });
  }
}
