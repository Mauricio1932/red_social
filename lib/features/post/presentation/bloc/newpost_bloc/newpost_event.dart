part of 'newpost_bloc.dart';

abstract class NewpostEvent {
  const NewpostEvent();
}

class NewPostRequest extends NewpostEvent {
  const NewPostRequest(this.newPost);
  final NewPost newPost;
}
