import '../../../domain/entities/comentarios.dart';

abstract class AddcommentEvent {
  const AddcommentEvent();
}

class NewCommenPost extends AddcommentEvent {
  const NewCommenPost(this.idPost);
  final Comentario idPost;
}
