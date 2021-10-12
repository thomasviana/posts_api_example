import '../models/comment.dart';
import '../models/user.dart';

import '../models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> fetchPosts(bool refreshFromServer);
  Future<List<Comment>> fetchPostDetails(int id);
  Future<User> fetchUserInfo(int id);
  Future<bool> markAsReaded(bool isReaded, Post post);
  Future<bool> isFavorite(Post post);
  Future<bool> deletePost(int id);
  Future<bool> deleteAllPosts();
}
