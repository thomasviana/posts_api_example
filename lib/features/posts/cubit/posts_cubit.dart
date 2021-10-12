import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/post.dart';
import '../data/repositories/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository repository;

  late List<Post> _all;

  PostsCubit(this.repository) : super(PostsInitial());

  void fetchPosts({required bool refreshFromServer}) async {
    emit(PostsLoadInProgress());
    // await Future.delayed(const Duration(seconds: 1));
    repository.fetchPosts(refreshFromServer).then((posts) {
      emit(PostsLoadSuccess(posts: posts));
      _all = posts;
    });
  }

  void markAsReaded(Post post) {
    repository.markAsReaded(!post.isReaded, post).then((isChanged) {
      if (isChanged) {
        updatePostList();
      }
    });
  }

  void showAll() {
    emit(PostsLoadSuccess(posts: _all));
  }

  void showFavorites() {
    final currentState = state;
    if (currentState is PostsLoadSuccess) {
      final postList = currentState.posts
          .where((element) => element.isFavorite == true)
          .toList();
      if (postList.isEmpty) {
        emit(PostsInitial());
      } else {
        emit(PostsLoadSuccess(posts: postList));
      }
    }
  }

  void deletePost(Post post) {
    repository.deletePost(post.id).then((isDetelted) {
      if (isDetelted) {
        final currentState = state;
        if (currentState is PostsLoadSuccess) {
          final postList = currentState.posts
              .where((postToDelete) => postToDelete.id != post.id)
              .toList();
          _all = postList;
          emit(PostsLoadSuccess(posts: postList));
        }
      }
    });
  }

  void clearAllPosts() {
    repository.deleteAllPosts().then((deleted) {
      if (deleted) {
        final currentState = state;
        if (currentState is PostsLoadSuccess) {
          final postList = currentState.posts;
          postList.clear();
          emit(PostsLoadSuccess(posts: postList));
        }
      }
    });
  }

  void updatePostList() {
    final currentState = state;
    if (currentState is PostsLoadSuccess) {
      emit(PostsLoadSuccess(posts: currentState.posts));
    }
  }
}
