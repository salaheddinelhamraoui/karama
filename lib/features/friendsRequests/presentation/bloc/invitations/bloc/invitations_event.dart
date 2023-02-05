part of 'invitations_bloc.dart';

abstract class InvitationsEvent extends Equatable {
  const InvitationsEvent();

  @override
  List<Object> get props => [];
}

class GetInvitationsEvent extends InvitationsEvent {}

class InvitationActionEvent extends InvitationsEvent {
  final List<Invitation> invitations;
  final Invitation invitation;
  final bool status;
  InvitationActionEvent(
      {required this.invitations,
      required this.invitation,
      required this.status});
}
