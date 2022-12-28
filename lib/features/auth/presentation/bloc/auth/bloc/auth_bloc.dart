import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/auth/domain/entities/user.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../domain/usecases/get_user.dart';
import '../../../../domain/usecases/login_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUseCase loginUser;
  final GetUserUseCase getUser;

  AuthBloc({required this.loginUser, required this.getUser})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInEvent) {
        print(event.mobileNumber);

        // emit(LoadingUserState());

        final failureOrDoneMessage =
            await loginUser(event.mobileNumber, event.password);

        final user = getUser();

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage),
        );
      } else if (event is getUserEvent) {
        final user = await getUser();
        emit(
          _eitherDoneMessageOrErrorState(user),
        );
      }
    });
  }

  AuthState _eitherDoneMessageOrErrorState(Either<Failure, User> either) {
    return either.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
      (user) => LoadedUserState(
        user: user,
      ),
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
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
