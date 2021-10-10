import '../models/comment.dart';
import '../models/user.dart';

import '../datasources/network_service.dart';
import '../models/post.dart';
import 'posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final NetworkService networkService;

  PostsRepositoryImpl({required this.networkService});

  @override
  Future<List<Post>> fetchPosts() async {
    final postsList = await networkService.fetchPosts();
    return postsList.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Future<bool> markAsReaded(bool completed, int id) async {
    final patchObj = {'isReaded': completed.toString()};
    return await networkService.patchpost(patchObj, id);
  }

  @override
  Future<bool> isFavorite(bool completed, int id) async {
    final patchObj = {'isfavorite': completed.toString()};
    return await networkService.patchpost(patchObj, id);
  }

  @override
  Future<bool> deletePost(int id) async {
    return await networkService.deletePost(id);
  }

  @override
  Future<List<Comment>> fetchPostDetails(int id) async {
    final postDetail = await networkService.fetchPostComments(id);
    return postDetail.map((e) => Comment.fromJson(e)).toList();
  }

  @override
  Future<User> fetchUserInfo(int userId) async {
    final userData = await networkService.fetchUserInfo(userId);
    return User.fromJson(userData);
  }
}
