import '../datasources/local_data_source.dart';

import '../datasources/remote_data_source.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Post>> fetchPosts(bool refreshFromServer) async {
    if (refreshFromServer) {
      final remotePosts = await remoteDataSource.fetchPosts();
      for (var post in remotePosts) {
        if (post.id <= 20) {
          post.isReaded = false;
        }
      }
      await localDataSource.cacheAllPosts(remotePosts);
      return remotePosts;
    } else {
      final cachedPosts = localDataSource.getCachedPosts();
      if (cachedPosts!.isNotEmpty) {
        return cachedPosts;
      } else {
        final remotePosts = await remoteDataSource.fetchPosts();
        for (var post in remotePosts) {
          if (post.id <= 20) {
            post.isReaded = false;
          }
        }
        await localDataSource.cacheAllPosts(remotePosts);
        return remotePosts;
      }
    }
  }

  @override
  Future<List<Comment>> fetchPostDetails(int id) async {
    final cachedComments = localDataSource.getCachedComments(id);
    if (cachedComments!.isNotEmpty) {
      return cachedComments;
    } else {
      final remoteComments = await remoteDataSource.fetchPostComments(id);
      await localDataSource.cacheAllComments(remoteComments, id);
      return remoteComments;
    }
  }

  @override
  Future<User> fetchUserInfo(int userId) async {
    final cachedUserInfo = localDataSource.getCachedUserInfo(userId);
    if (cachedUserInfo != null) {
      print('cachedUserInfo');
      return cachedUserInfo;
    } else {
      print('remoteUserInfo');
      final remoteUserInfo = await remoteDataSource.fetchUserInfo(userId);
      await localDataSource.cacheAllUserInfo(remoteUserInfo, userId);
      return remoteUserInfo;
    }
  }

  @override
  Future<bool> markAsReaded(bool isReaded, Post post) async {
    final patchObj = {'isReaded': isReaded.toString()};
    localDataSource.markAsReaded(post);
    return await remoteDataSource.patchPost(patchObj, post.id);
  }

  @override
  Future<bool> isFavorite(Post post) async {
    final patchObj = {'isFavorite': post.isFavorite.toString()};
    localDataSource.isFavorite(post);
    return await remoteDataSource.patchPost(patchObj, post.id);
  }

  @override
  Future<bool> deleteAllPosts() async {
    localDataSource.deleteAllPosts();
    return await remoteDataSource.deleteAllPosts();
  }

  @override
  Future<bool> deletePost(int id) async {
    localDataSource.deletePost(id);
    return await remoteDataSource.deletePost(id);
  }
}
