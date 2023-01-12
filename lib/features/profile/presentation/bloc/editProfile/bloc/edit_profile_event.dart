part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class PostEditProfileEvent extends EditProfileEvent {
  final User user;

  PostEditProfileEvent({required this.user});
}
