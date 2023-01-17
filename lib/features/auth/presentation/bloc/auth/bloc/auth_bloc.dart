import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/auth/domain/entities/user.dart';

import '../../../../../../core/error/error_message.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/get_token.dart';
import '../../../../domain/usecases/get_user.dart';
import '../../../../domain/usecases/login_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUseCase loginUser;
  final GetUserUseCase getUser;
  final GetTokenUseCase getToken;

  AuthBloc(
      {required this.loginUser, required this.getUser, required this.getToken})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInEvent) {
        emit(LoadingUserState());
        final failureOrDoneMessage =
            await loginUser(event.mobileNumber, event.password);

        final tokenOrFailure = await getToken();

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, tokenOrFailure),
        );
      } else if (event is getUserEvent) {
        emit(LoadingUserState());
        final failureOrDoneMessage = await getUser();
        final tokenOrFailure = await getToken();

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, tokenOrFailure),
        );
      }
    });
  }

  AuthState _eitherDoneMessageOrErrorState(
      Either<Failure, User> either, Either<Failure, String> either2) {
    return either.fold(
      (failure) => ErrorUserState(message: mapFailureToMessage(failure)),
      (user) => either2.fold(
          (failure) => ErrorUserState(message: mapFailureToMessage(failure)),
          (token) => LoadedUserState(user: user, token: token)),
    );
  }
}
