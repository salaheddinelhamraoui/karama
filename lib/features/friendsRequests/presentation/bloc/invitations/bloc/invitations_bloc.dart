import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../domain/entities/invitation.dart';
import '../../../../domain/usecases/get_invitations.dart';
import '../../../../domain/usecases/invitation_actions.dart';

part 'invitations_event.dart';
part 'invitations_state.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final GetInvitationsUseCase getInvitations;
  final InvitationActionUseCase InvitationAction;

  InvitationsBloc(
      {required this.getInvitations, required this.InvitationAction})
      : super(InvitationsInitial()) {
    on<InvitationsEvent>((event, emit) async {
      if (event is GetInvitationsEvent) {
        emit(InvitationsLoadingState());
        final failureOrDoneMessage = await getInvitations();
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingInvitationsState(
            message: mapFailureToMessage(failure),
          ),
          (invitations) => InvitationsLoadedState(invitations: invitations),
        ));
      } else if (event is InvitationActionEvent) {
        emit(InvitationsLoadingState());
        final failureOrDoneMessage =
            await InvitationAction(event.invitation, event.status);

        var filteredInvitations = event.invitations
            .where((invitation) =>
                int.parse(invitation.id) == int.parse(event.invitation.id))
            .toList();

        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingInvitationsState(
            message: mapFailureToMessage(failure),
          ),
          (invitations) =>
              InvitationsLoadedState(invitations: filteredInvitations),
        ));
      }
    });
  }
}
