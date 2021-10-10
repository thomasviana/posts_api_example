part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoadInProgress extends PostsState {}

class PostsLoadSuccess extends PostsState {
  final List<Post> posts;

  PostsLoadSuccess({required this.posts});
}
