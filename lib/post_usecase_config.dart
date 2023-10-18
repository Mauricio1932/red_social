import 'package:red_social/post/data/datasource/post_datasource.dart';
import 'package:red_social/post/domain/usecase/getpost_usecase.dart';
import 'post/data/repositories/post_respoitory_impl.dart';

class UseCasePostsConfig {
  ApiPostDataSourceImpl? apiPostDataSourceImpl;
  PostRepositoryImpl? postRepositoryImpl;

  GetAllPostUseCase? getAllPostUseCase;

  UseCasePostsConfig() {
    apiPostDataSourceImpl = ApiPostDataSourceImpl();
    postRepositoryImpl = PostRepositoryImpl(apiPostDataSourceImpl: apiPostDataSourceImpl!);

    getAllPostUseCase = GetAllPostUseCase(postRepositoryImpl!);
  }
}
