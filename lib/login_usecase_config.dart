import 'features/user/data/datasource/user_data_source.dart';
import 'features/user/data/respositories/user_repository_impl.dart';
import 'features/user/domain/usecase/create_user_case.dart';
import 'features/user/domain/usecase/delete_token_usecase.dart';
import 'features/user/domain/usecase/getTokenUsecase.dart';
import 'features/user/domain/usecase/login_usecase.dart';

class UseCaseUserConfig {
  ApiUserDatasourceImp? apiUserDatasourceImp;
  UserRepositoryImpl? userRepositoryImpl;

  LoginUserUsecase? loginUserUsecase;
  // UserUsecase? userUsecase;
  UserCreateUseCase? userCreateUseCase;
  RemoveTokenUseCase? removeTokenUseCase;
  GetAuthTokenUseCase? getAuthTokenUseCase;
  // UpdateUserUsecase? updateUserUsecase;

  UseCaseUserConfig() {
    apiUserDatasourceImp = ApiUserDatasourceImp();
    userRepositoryImpl = UserRepositoryImpl(apiUserDatasourceImp: apiUserDatasourceImp!);

    loginUserUsecase = LoginUserUsecase(userRepositoryImpl!);
    userCreateUseCase = UserCreateUseCase(userRepositoryImpl!);
    removeTokenUseCase = RemoveTokenUseCase(userRepositoryImpl!);
    getAuthTokenUseCase = GetAuthTokenUseCase(userRepositoryImpl!);
  }
}
