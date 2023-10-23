import '../../../domain/entities/newpost.dart';

enum NewPRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class NewpostState {
  const NewpostState({
    this.newPost = const [],
    this.npStatus = NewPRequest.unknown,
    this.newPostId = const {},
  });

  final List<NewPost> newPost;
  final NewPRequest npStatus;
  final Set<int> newPostId;

  NewpostState copyWith({
    List<NewPost>? newPost,
    NewpostState? postState,
    Set<int>? newPostId,
    required npStatus,
  }) =>
      NewpostState(
        newPost: newPost ?? this.newPost,
        npStatus: npStatus?? this.npStatus,
        newPostId: newPostId ?? this.newPostId,
      );
}

// final class NewpostInitial extends NewpostState {}
