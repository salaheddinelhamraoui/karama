import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/auth/domain/entities/user.dart';

import '../../../../../../core/error/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
  }

  AuthState _mapFailureOrPostsToState(Either<Failure, User> either) {
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
