import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/signup_user.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  final SignUpUserUseCase signUp;

  TempBloc({required this.signUp}) : super(TempInitial()) {
    on<TempEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(LoadingTempState());
        final failureOrDoneMessage = await signUp(event.mobileNumber);
        print('4');
        print(failureOrDoneMessage);
        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage),
        );
      }
    });
  }
  TempState _eitherDoneMessageOrErrorState(Either<Failure, String> either) {
    return either.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
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
        return 'Phone Number Not Invited';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
