import 'package:http/http.dart' as http;
import 'package:red_social/post/data/models/post_models.dart';
import 'dart:convert';

import '../../domain/entities/post.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPost();
}

class ApiPostDataSourceImpl implements PostDataSource {
  // final urlGetPost = "https://fakestoreapi.com/products/";
  final urlGetPost = "http://localhost:3000/api/post/viewAll";

  @override
  Future<List<Post>> getAllPost() async {

    final response = await http.get(Uri.parse(urlGetPost));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      final locals =
          body.map((dynamic item) => PostModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }
}
