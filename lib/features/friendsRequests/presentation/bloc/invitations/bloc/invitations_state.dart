part of 'invitations_bloc.dart';

abstract class InvitationsState extends Equatable {
  const InvitationsState();

  @override
  List<Object> get props => [];
}

class InvitationsInitial extends InvitationsState {}

class InvitationsLoadingState extends InvitationsState {}

class InvitationsLoadedState extends InvitationsState {
  final List<Invitation> invitations;

  InvitationsLoadedState({required this.invitations});

  @override
  List<Object> get props => [invitations];
}

class ErrorLoadingInvitationsState extends InvitationsState {
  final String message;

  const ErrorLoadingInvitationsState({required this.message});
}
