import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:karama/features/requests/domain/usecases/get_tags.dart';

import '../../../../../core/error/error_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/tag_category.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final GetTagsUseCase getTags;
  TagsBloc({required this.getTags}) : super(TagsInitial()) {
    on<TagsEvent>((event, emit) async {
      if (event is GetTagsEvent) {
        emit(TagsLoadingState());
        final failureOrDoneMessage = await getTags();

        emit(failureOrDoneMessage.fold(
          (failure) => ErrorLoadingTagsState(
            message: mapFailureToMessage(failure),
          ),
          (tags) => TagsLoadedState(tags: tags),
        ));
      }
    });
  }
}
