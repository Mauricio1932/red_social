import 'dart:io';

import '../../domain/entities/newpost.dart';

class  NewPostModel extends NewPost {
  NewPostModel({
    // required int id,
    required String texto,
    required File imagen,
    // required String description,
  }) : super(
          // // id: id,
          texto: texto,
          imagen: imagen,
          // // description: description,
        );

  factory NewPostModel.fromJson(Map<String, dynamic> json) {
    return NewPostModel(
      // // id: json['id'],
      texto: json['texto'],
      imagen: json['imagen'],
      // // description: json['description'],
    );
  }

  factory NewPostModel.fromEntity(NewPost post) {
    return NewPostModel(
      // // id: post.id,
      texto: post.texto,
      imagen: post.imagen,
      // // description: post.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // // 'id': id,
      'texto': texto,
      'imagen': imagen,
      // // 'description': description,
    };
  }
}
