import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/usecases/get_tags.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/tag_category.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final GetTagsUseCase getTags;
  TagsBloc({required this.getTags}) : super(TagsInitial()) {
    on<TagsEvent>((event, emit) async {
      if (event is getTagsEvent) {
        emit(TagsLoadingState());
        final failureOrDoneMessage = await getTags();

        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingTagsState(
            message: _mapFailureToMessage(failure),
          ),
          (tags) => TagsLoadedState(tags: tags),
        ));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Please try again later.';
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
