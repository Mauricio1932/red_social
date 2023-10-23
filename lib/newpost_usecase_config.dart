import 'package:red_social/features/post/data/datasource/post_datasource.dart';
import 'features/post/data/repositories/post_respoitory_impl.dart';
import 'features/post/domain/usecase/newpost_usecase.dart';

class UseCaseNewPostsConfig {
  ApiPostDataSourceImpl? apiPostDataSourceImpl;
  PostRepositoryImpl? postRepositoryImpl;

  PostNewUseCase? postNewUseCase;

  UseCaseNewPostsConfig() {
    apiPostDataSourceImpl = ApiPostDataSourceImpl();
    postRepositoryImpl = PostRepositoryImpl(apiPostDataSourceImpl: apiPostDataSourceImpl!);

    postNewUseCase = PostNewUseCase(postRepositoryImpl!);
  }
}
