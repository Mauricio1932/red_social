import 'package:red_social/features/post/domain/entities/post.dart';

enum PostRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class PostState {
  const PostState({
    this.posts = const [],
    this.postsStatus = PostRequest.unknown,
    this.postId = const {},
  });

  final List<Post> posts;
  final PostRequest postsStatus;
  final Set<int> postId;

  PostState copyWith({
    List<Post>? posts,
    PostState? postState,
    Set<int>? postId,
    required postsStatus,
  }) =>
      PostState(
        posts: posts ?? this.posts,
        postsStatus: postsStatus ?? this.postsStatus,
        postId: postId ?? this.postId,
      );
}
