import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:karama/features/auth/domain/usecases/get_temp_data.dart';
import 'package:karama/features/auth/domain/usecases/verify_user.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/get_verify_state.dart';
import '../../../../domain/usecases/signup_user.dart';
import '../../../../domain/usecases/submit_onboarding_data.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  final SignUpUserUseCase signUp;
  final VerifyUserUseCase verifyUser;
  final GetVerifyUseCase getVerifyUseCase;
  final GetTempDataUseCase getTempDataUseCase;
  final SubmitOnboardingDataUseCase submitOnboardingDataUseCase;

  TempBloc(
      {required this.signUp,
      required this.getVerifyUseCase,
      required this.verifyUser,
      required this.getTempDataUseCase,
      required this.submitOnboardingDataUseCase})
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
              message: mapFailureToMessage(failure),
              mobileNumber: event.mobileNumber),
          (token) => TempDataState(
              mobileNumber: event.mobileNumber,
              token: token,
              verifyState: true),
        ));
      } else if (event is ChoosePasswordEvent) {
        emit(LoadingTempState());
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
      } else if (event is SubmitOnboardingDataEvent) {
        emit(LoadingTempState());
        emit(ErrorTempState(
            message: mapFailureToMessage(ServerFailure()),
            mobileNumber: event.mobileNumber,
            password: event.password,
            token: event.token));

        final state = await submitOnboardingDataUseCase(
            event.avatar,
            event.firstName,
            event.lastName,
            event.gender,
            event.country,
            event.state,
            event.city,
            event.token,
            event.mobileNumber,
            event.password);

        emit(state.fold(
          (failure) => ErrorTempState(
              message: mapFailureToMessage(failure),
              mobileNumber: event.mobileNumber,
              password: event.password,
              token: event.token),
          (state) => state == 'done'
              ? SignUpDoneState()
              : ErrorTempState(
                  message: mapFailureToMessage(ServerFailure()),
                  mobileNumber: event.mobileNumber,
                  password: event.password,
                  token: event.token),
        ));
      }
    });
  }
  TempState _eitherDoneMessageOrErrorState(Either<Failure, String> either) {
    return either.fold(
      (failure) => ErrorTempState(message: mapFailureToMessage(failure)),
      (mobileNumber) => TempDataState(mobileNumber: mobileNumber),
    );
  }
}
