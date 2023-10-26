import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:red_social/features/post/data/models/comentario_model.dart';
import 'package:red_social/features/post/data/models/new_post_model.dart';
import 'package:red_social/features/post/data/models/post_models.dart';
import 'package:red_social/features/post/domain/entities/comentarios.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/newpost.dart';
import '../../domain/entities/post.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPost();
  Future<List<NewPost>> postNew(newPost);
  Future<List<Comentario>> getComentarios(idPost);
  Future<List<Comentario>> newComentario(idPost);
}

class ApiPostDataSourceImpl implements PostDataSource {
  Dio dio = Dio();
  String ip = '';
  final urlGetPost = "http://localhost:3000/api/post/viewAll";
  final urlGetComentarios = "http://localhost:3000/api/comment/view?post_id=";
  final postNewUrl = "http://localhost:3000/api/post/createPost?user_id=";
  final newCommentUrl = "http://localhost:3000/api/comment/create?post_id=";

  @override
  Future<List<Post>> getAllPost() async {
    final response = await http.get(Uri.parse(urlGetPost));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
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

    final idUsers = sharedPreferences.getString('id_user') ?? '';

    // Reemplaza 'path_to_your_image' con la ruta real de tu imagen

    String fileName = newPost.imagen!.path.split('/').last;
    FormData formData = FormData.fromMap(
      {
        'texto': newPost.texto,
        'imagen': await MultipartFile.fromFile(newPost.imagen.path,
            filename: fileName),
      },
    );

    // sharedPreferences.setString('users', jsonEncode(token));
    String token = sharedPreferences.getString('auth_token') ?? "";
    try {
      Response response = await dio.post(
        '$postNewUrl$idUsers',
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
        return newPosts;
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to upload image');
    }
  }

  @override
  Future<List<Comentario>> getComentarios(idPost) async {
    final response =
        await http.get(Uri.parse('$urlGetComentarios${idPost.post_id}'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      final comentarios =
          body.map((dynamic item) => ComentarioModel.fromJson(item)).toList();

      return comentarios;
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<List<Comentario>> newComentario(idPost) async {
    // Dio dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // final idUsers = sharedPreferences.getString('id_user') ?? '';

    // Reemplaza 'path_to_your_image' con la ruta real de tu imagen
    String token = sharedPreferences.getString('auth_token') ?? "";
    String name = sharedPreferences.getString('name') ?? "";

    print("ejecuto datasourse: ${name}");
    

    try {
      Response response = await dio.post(
        '$newCommentUrl${idPost.post_id}',
        options: Options(
          headers: {
            'auth-token': token,
          },
        ),
        data: {
          'name': name,
          'comment': idPost.comment,
        },
      );

      if (response.statusCode == 200) {
        // Reemplaza 'NewPost.fromJson' con la lógica real para convertir la respuesta a una lista de NewPost
        List<Comentario> comentarioadd = response.data
            .map<Comentario>((post) => ComentarioModel.fromJson(post))
            .toList();
        return comentarioadd;
      } else {
        throw Exception('Failed to comment');
      }
    } catch (e) {
      throw Exception('Failed to $e');
    }
  }
}
