import 'features/post/data/datasource/post_datasource.dart';

import 'features/post/data/repositories/post_respoitory_impl.dart';
import 'features/post/domain/usecase/get_comentarios_usecase.dart';
import 'features/post/domain/usecase/newcomentario_usecase.dart';

class UseCaseComentarioConfig {
  ApiPostDataSourceImpl? apiPostDataSourceImpl;
  PostRepositoryImpl? postRepositoryImpl;

  GetComentariosUseCase? getComentariosUseCase;
  NewComentarioUseCase? newComentarioUseCase;
  
  UseCaseComentarioConfig() {
    apiPostDataSourceImpl = ApiPostDataSourceImpl();
    postRepositoryImpl =
        PostRepositoryImpl(apiPostDataSourceImpl: apiPostDataSourceImpl!);

    getComentariosUseCase = GetComentariosUseCase(postRepositoryImpl!);
    newComentarioUseCase = NewComentarioUseCase(postRepositoryImpl!);
  }
}
