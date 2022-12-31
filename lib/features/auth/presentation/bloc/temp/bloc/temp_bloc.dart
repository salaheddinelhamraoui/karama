import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/auth/domain/usecases/get_temp_data.dart';
import 'package:karama/features/auth/domain/usecases/verify_user.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/get_verify_state.dart';
import '../../../../domain/usecases/signup_user.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  final SignUpUserUseCase signUp;
  final VerifyUserUseCase verifyUser;
  final GetVerifyUseCase getVerifyUseCase;
  final GetTempDataUseCase getTempDataUseCase;

  TempBloc(
      {required this.signUp,
      required this.getVerifyUseCase,
      required this.verifyUser,
      required this.getTempDataUseCase})
      : super(TempInitial()) {
    on<TempEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(LoadingTempState());
        final failureOrDoneMessage = await signUp(event.mobileNumber);
        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage),
        );
      } else if (event is VerifyUserEvent) {
        emit(LoadingTempState());
        final failureOrDoneMessage =
            await verifyUser(event.pinCode, event.mobileNumber);
        emit(failureOrDoneMessage.fold(
          (failure) => ErrorTempState(
              message: _mapFailureToMessage(failure),
              mobileNumber: event.mobileNumber),
          (token) => TempDataState(
              mobileNumber: event.mobileNumber,
              token: token,
              verifyState: true),
        ));
      } else if (event is ChoosePasswordEvent) {
        emit(TempDataState(
            mobileNumber: event.mobileNumber,
            token: event.token,
            password: event.password));
      } else if (event is GetTempDataEvent) {
        final data = await getTempDataUseCase();

        emit(TempDataState(
            mobileNumber: data['mobileNumber'] ?? '',
            token: data['token'],
            verifyState: data['verifyState'] == 'true'));
      }
    });
  }
  TempState _eitherDoneMessageOrErrorState(Either<Failure, String> either) {
    return either.fold(
      (failure) => ErrorTempState(message: _mapFailureToMessage(failure)),
      (mobileNumber) => TempDataState(mobileNumber: mobileNumber),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Please try again later .';
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
        return "Unexpected Error , Please try again later .";
    }
  }
}
