import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:red_social/features/post/data/models/new_post_model.dart';
import 'package:red_social/features/post/data/models/post_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/newpost.dart';
import '../../domain/entities/post.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPost();
  Future<List<NewPost>> postNew(newPost);
}

class ApiPostDataSourceImpl implements PostDataSource {
  // final urlGetPost = "https://fakestoreapi.com/products/";
  final urlGetPost = "http://localhost:3000/api/post/viewAll";
  final postNewUrl = "http://localhost:3000/api/post/createPost?user_id=";
  // final urlNewPost ='http://localhost:3000/api/post/createPost?user_id=';
  @override
  Future<List<Post>> getAllPost() async {
    final response = await http.get(Uri.parse(urlGetPost));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print("body:  $body");
      final locals =
          body.map((dynamic item) => PostModel.fromJson(item)).toList();

      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<List<NewPost>> postNew(newPost) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    final id_users = sharedPreferences.getString('id_user') ?? '';

    print("${id_users}");
    print("${postNewUrl}");
    Dio dio = Dio();
    // Reemplaza 'path_to_your_image' con la ruta real de tu imagen
    print("${newPost.imagen}");
    String fileName = newPost.imagen!.path.split('/').last;
    FormData formData = FormData.fromMap({
      'texto': newPost.texto,
      'imagen':
          await MultipartFile.fromFile(newPost.imagen.path, filename: fileName),
    });

    // sharedPreferences.setString('users', jsonEncode(token));
    String token = sharedPreferences.getString('auth_token') ?? "";
    try {
      Response response = await dio.post(
        '$postNewUrl$id_users',
        options: Options(
          headers: {
            'auth-token': token,
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        // Reemplaza 'NewPost.fromJson' con la lógica real para convertir la respuesta a una lista de NewPost
        List<NewPost> newPosts = response.data
            .map<NewPost>((post) => NewPostModel.fromJson(post))
            .toList();
        print("Solicitud exitosa: $newPosts");
        return newPosts;
      } else {
        print(
            "Error en la solicitud. Código de estado: ${response.statusCode}");
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      throw Exception('Failed to upload image');
    }
  }
}
