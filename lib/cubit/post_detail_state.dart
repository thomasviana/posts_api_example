part of 'post_detail_cubit.dart';

@immutable
abstract class PostDetailState {}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoadInProgress extends PostDetailState {}

class PostDetailLoadSuccess extends PostDetailState {
  final Post post;
  final List<Comment> comments;
  final User user;

  PostDetailLoadSuccess({
    required this.post,
    required this.comments,
    required this.user,
  });
}

class PostDetailEditSuccess extends PostDetailState {
  final Post post;

  PostDetailEditSuccess({required this.post});
}
