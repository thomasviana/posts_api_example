import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:posts_api_example/cubit/segmented_control_cubit.dart';
import 'package:posts_api_example/data/models/comment.dart';
import 'package:posts_api_example/data/models/user.dart';

import '../data/models/post.dart';
import '../data/repositories/posts_repository.dart';
import 'posts_cubit.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  final PostsRepository repository;
  final PostsCubit postsCubit;
  final SegmentedControlCubit segmentedControlCubit;

  PostDetailCubit(
    this.repository,
    this.postsCubit,
    this.segmentedControlCubit,
  ) : super(PostDetailInitial());

  void fetchPostDetails(Post post) async {
    emit(PostDetailLoadInProgress());
    final comments = await repository.fetchPostDetails(post.id);
    final user = await repository.fetchUserInfo(post.userId);
    emit(PostDetailLoadSuccess(post: post, comments: comments, user: user));
  }

  void isFavorite(Post post) {
    repository.isFavorite(!post.isFavorite, post.id).then((isChanged) {
      if (isChanged) {
        post.isFavorite = !post.isFavorite;
        if (segmentedControlCubit.state
            is SegmentedControlSetFavoritesSuccess) {
          postsCubit.showFavorites();
        }
        postsCubit.updatePostList();
        emit(PostDetailEditSuccess(post: post));
      }
    });
  }

  void updatePostDetail(Post post) {
    final currentState = postsCubit.state;
    if (currentState is PostsLoadSuccess) {
      emit(PostDetailEditSuccess(post: post));
    }
  }
}
