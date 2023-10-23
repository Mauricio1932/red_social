import 'dart:io';

class NewPost {
  final int id;
  final String texto;
  final File imagen;

  NewPost({
    required this.id,
    required this.texto,
    required this.imagen,
  });
}
