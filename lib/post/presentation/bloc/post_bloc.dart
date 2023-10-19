import 'package:bloc/bloc.dart';
import 'package:red_social/post/domain/usecase/getpost_usecase.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUseCase getAllPostUseCase;

  PostBloc(this.getAllPostUseCase) : super(const PostState()) {
    on<PostsGetRequest>(_handlePostRecuested);
    // on<LocalSingleView>(_handleViewLocal);
    // on<DeleteLocalSingleView>(_handleCloseViewLocal);
    // on<LocalSingleRequest>(_handleSinglePostRecuested);
  }

  Future<void> _handlePostRecuested(
    event,
    Emitter<PostState> emit,
  ) async {
    // print("data 1");
    try {
      emit(state.copyWith(
        postsStatus: PostRequest.requestInProgress,
      ));

      final response = await getAllPostUseCase.execute();
    
      emit(
        state.copyWith(
          postsStatus: PostRequest.requestSuccess,
          posts: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        postsStatus: PostRequest.requestFailure,
      ));
    }
  }
}
