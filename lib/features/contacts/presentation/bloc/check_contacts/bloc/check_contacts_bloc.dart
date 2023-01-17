import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/error/error_message.dart';
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
            message: mapFailureToMessage(failure),
          ),
          (contacts) => CheckContactsLoadedState(contacts: contacts),
        ));
      
      }
    });
  }
}
