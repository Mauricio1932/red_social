import '../entities/user.dart';
import '../repository/login_repository.dart';

class UserCreateUseCase {
  final LoginUserRepository userRepository;

  UserCreateUseCase(this.userRepository);
  Future<List<UserCreate>> execute(UserCreate user)async {
    // print("caso get token");
    return await userRepository.userCreate(user);
  }
}
