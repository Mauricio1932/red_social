import 'package:red_social/features/post/domain/entities/comentarios.dart';

abstract class ComentarioEvent {
  const ComentarioEvent();
}

class GetCommentRequest extends ComentarioEvent{
  const GetCommentRequest(this.idPost);
  final Comentario idPost;
}