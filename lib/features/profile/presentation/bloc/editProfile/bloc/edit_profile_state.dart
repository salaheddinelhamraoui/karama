part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditingProfileState extends EditProfileState {}

class ProfileEditedState extends EditProfileState {}

class ErrorEditingProfileState extends EditProfileState {
  final String message;

  const ErrorEditingProfileState({required this.message});
}
