part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  PostsLoaded({
    required this.posts,
  });
}

class PostsLoading extends PostsState {
  final List<PostModel> oldPosts;
  final bool isFirstFetch;
  PostsLoading({
    required this.oldPosts,
    this.isFirstFetch = false,
  });
}
