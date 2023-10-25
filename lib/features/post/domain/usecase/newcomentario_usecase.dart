import 'package:red_social/features/post/domain/entities/comentarios.dart';

import '../entities/newpost.dart';
import '../repository/post_repository.dart';

class NewComentarioUseCase {
  final PostRepository postRepository;

  NewComentarioUseCase(this.postRepository);

  Future<List<Comentario>> execute(Comentario id) async {
    print("use case bien");
    try {
      final comentarioadd = await postRepository.newComentario(id);

      // ignore: avoid_print
      // ignore: unnecessary_null_comparison
      if (comentarioadd != null) {
        // ignore: avoid_print
        // print("$posts");
        return comentarioadd;
      } else {
        throw Exception('No se pudo obtener los posts');
      }
    } catch (e) {
      print("Error caso de uso $e");
      throw (e);
    }
  }
}
