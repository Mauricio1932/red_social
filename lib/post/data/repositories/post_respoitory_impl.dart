import 'package:red_social/post/data/datasource/post_datasource.dart';
import 'package:red_social/post/domain/entities/post.dart';
import 'package:red_social/post/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiPostDataSourceImpl apiPostDataSourceImpl;

  PostRepositoryImpl({required this.apiPostDataSourceImpl});

  @override
  Future<List<Post>> getAllPost() async {
    return await apiPostDataSourceImpl.getAllPost();
  }
}
