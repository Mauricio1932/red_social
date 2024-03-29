import 'package:red_social/features/post/data/datasource/post_datasource.dart';
import 'package:red_social/features/post/domain/usecase/getpost_usecase.dart';
import 'features/post/data/repositories/post_respoitory_impl.dart';

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
