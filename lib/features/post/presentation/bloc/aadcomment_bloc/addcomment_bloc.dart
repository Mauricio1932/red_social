import 'package:bloc/bloc.dart';

import '../../../domain/usecase/newcomentario_usecase.dart';
import 'addcomment_event.dart';
import 'addcomment_state.dart';
// import 'package:meta/meta.dart';

class AddcommentBloc extends Bloc<AddcommentEvent, AddcommentState> {
  final NewComentarioUseCase newComentarioUseCase;
  AddcommentBloc(this.newComentarioUseCase) : super(const AddcommentState()) {
    on<NewCommenPost>(_handleNewCommentRecuested);
  }

  Future<void> _handleNewCommentRecuested(
    event,
    Emitter<AddcommentState> emit,
  ) async {
    print("data comment");
    try {
      emit(state.copyWith(
        postsStatus: CommentRequest.requestInProgress,
      ));

      final response = await newComentarioUseCase.execute(event.idPost);

      emit(
        state.copyWith(
          postsStatus: CommentRequest.requestSuccess,
          comentario: response,
        ),
      );
    } catch (e) {
      print('error en bloc  $e'); // Agrega esta línea para imprimir la excepción
      emit(state.copyWith(
        postsStatus: CommentRequest.requestFailure,
      ));
    }
  }
}
