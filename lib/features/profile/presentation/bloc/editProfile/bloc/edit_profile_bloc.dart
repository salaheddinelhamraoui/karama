import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../auth/domain/entities/user.dart';
import '../../../../../auth/domain/usecases/edit_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase editProfile;
  EditProfileBloc({required this.editProfile}) : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) async {
      if (event is PostEditProfileEvent) {
        emit(EditingProfileState());
        final failureOrDoneMessage = await editProfile(event.user);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorEditingProfileState(
            message: mapFailureToMessage(failure),
          ),
          (done) => ProfileEditedState(),
        ));
      }
    });
  }
}
