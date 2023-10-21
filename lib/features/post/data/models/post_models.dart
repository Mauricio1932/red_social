import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int id,
    // required String texto,
    required String imagen,
    // required String description,
  }) : super(
          id: id,
          // // texto: texto,
          imagen: imagen,
          // // description: description,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      // // texto: json['texto'],
      imagen: json['imagen'],
      // // description: json['description'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      // // texto: post.texto,
      imagen: post.imagen,
      // // description: post.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // // 'texto': texto,
      'imagen': imagen,
      // // 'description': description,
    };
  }
}
