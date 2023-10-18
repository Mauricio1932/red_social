import '../entities/post.dart';
import '../repository/post_repository.dart';

class GetAllPostUseCase {
  final PostRepository postRepository;

  GetAllPostUseCase(this.postRepository);

  Future<List<Post>> execute() async {
    try {
      final posts = await postRepository.getAllPost();

      // ignore: avoid_print
      // ignore: unnecessary_null_comparison
      if (posts != null){
        print("$posts");
        return posts;
      }else{
        throw Exception('No se pudo obtener los posts');
      }
    } catch (e) {
      print("Error $e");
      throw (e);
    }
  }
}
