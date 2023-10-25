import '../../../domain/entities/comentarios.dart';

enum CommentRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class AddcommentState {
  const AddcommentState({
    this.comentario = const [],
    this.commentStatus = CommentRequest.unknown,
    this.comentarioId = const {},
  });
  final List<Comentario> comentario;
  final CommentRequest commentStatus;
  final Set<int> comentarioId;

  AddcommentState copyWith({
    List<Comentario>? comentario,
    AddcommentState? comentState,
    Set<int>? comentarioId,
    required postsStatus,
  }) =>
      AddcommentState(
        comentario: comentario ?? this.comentario,
        commentStatus: commentStatus,
        comentarioId: comentarioId ?? this.comentarioId,
      );
}