import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required String id,
    required String title,
    required String imagen,
    required String description,
    // required String type,
  }) : super(
          id: id,
          title: title,
          imagen: imagen,
          description: description,
          // // type: type,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      imagen: json['imagen'],
      description: json['description'],
      // // type: json['type'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      title: post.title,
      imagen: post.imagen,
      description: post.description,
      // // type: post.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagen': imagen,
      'description': description,
      // // 'type': type,
    };
  }
}
