import '../entities/newpost.dart';
import '../repository/post_repository.dart';

class PostNewUseCase {
  final PostRepository postRepository;

  PostNewUseCase(this.postRepository);

  Future<List<NewPost>> execute(NewPost newPost) async {
    try {
      final posts = await postRepository.postNew(newPost);

      // ignore: avoid_print
      // ignore: unnecessary_null_comparison
      if (posts != null) {
        // ignore: avoid_print
        print("Se publico el post");
        return posts;
      } else {
        throw Exception('No se pudo obtener los posts');
      }
    } catch (e) {
      print("Error caso de uso $e");
      throw (e);
    }
  }
}
