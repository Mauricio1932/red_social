import 'package:red_social/features/post/domain/entities/newpost.dart';

import '../entities/comentarios.dart';
import '../entities/post.dart';

abstract class PostRepository{
  Future<List<Post>> getAllPost();
  Future<List<NewPost>> postNew(newPost);
  Future<List<Comentario>> getComentarios(id);
}