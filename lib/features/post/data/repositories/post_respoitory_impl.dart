import 'package:red_social/features/post/data/datasource/post_datasource.dart';
import 'package:red_social/features/post/domain/entities/comentarios.dart';
import 'package:red_social/features/post/domain/entities/post.dart';
import 'package:red_social/features/post/domain/repository/post_repository.dart';

import '../../domain/entities/newpost.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiPostDataSourceImpl apiPostDataSourceImpl;

  PostRepositoryImpl({required this.apiPostDataSourceImpl});

  @override
  Future<List<Post>> getAllPost() async {
    return await apiPostDataSourceImpl.getAllPost();
  }

  @override
  Future<List<NewPost>> postNew(newPost) async {
    return await apiPostDataSourceImpl.postNew(newPost);
  }

  @override
  Future<List<Comentario>> getComentarios(idPost) async {
    return await apiPostDataSourceImpl.getComentarios(idPost);
  }

  @override
  Future<List<Comentario>> newComentario(idPost) async {
    return await apiPostDataSourceImpl.newComentario(idPost);
  }
}
