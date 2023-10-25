import 'package:red_social/features/post/domain/entities/comentarios.dart';

import '../repository/post_repository.dart';

class GetComentariosUseCase {
  final PostRepository postRepository;

  GetComentariosUseCase(this.postRepository);

  Future<List<Comentario>> execute(idPost) async {
    try {
      final comentario = await postRepository.getComentarios(idPost);

      // ignore: avoid_print
      // ignore: unnecessary_null_comparison
      if (comentario != null) {
        // print("$comentario");
        return comentario;
      } else {
        throw Exception('No se pudo obtener los posts');
      }
    } catch (e) {
      print("Error use case $e");
      throw (e);
    }
  }
}
