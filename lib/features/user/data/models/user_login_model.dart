
import '../../domain/entities/login.dart';

class UserLoginModel extends User {
  UserLoginModel({
    required String name,
    required String pass,
    required String token,
  }) : super(
          name: name,
          pass: pass,
          token: token,
        );

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      name: json['name'],
      pass: json['pass'],
      token: json['token'],
    );
  }

  factory UserLoginModel.fromEntity(User user) {
    return UserLoginModel(
      name: user.name,
      pass: user.pass,
      token: user.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pass': pass,
      'token': token,
    };
  }
}
