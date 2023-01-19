import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/entities/contact.dart';
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

        List<String> listContactsNumbers = [];
        for (var i = 0; i < event.contacts.length; i++) {
          listContactsNumbers.add(event.contacts[i].contactNumber);
        }

        final failureOrDoneMessage = await checkContacts(listContactsNumbers);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorCheckContactsState(
            message: mapFailureToMessage(failure),
          ),
          (remoteContacts) {
            List<CustomContact> filteredContacts = event.contacts;

            for (var contact in remoteContacts) {
              filteredContacts = filteredContacts
                  .where((i) => i.contactNumber != contact.contactNumber)
                  .toList();
            }

            return CheckContactsLoadedState(
                contacts: [...remoteContacts, ...filteredContacts]);
          },
        ));
      }
    });
  }
}
