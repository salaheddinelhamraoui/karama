import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
            message: _mapFailureToMessage(failure),
          ),
          (done) => ProfileEditedState(),
        ));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Something went wrong, pleases try again later.';
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
