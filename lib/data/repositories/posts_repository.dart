import '../models/comment.dart';
import '../models/user.dart';

import '../models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> fetchPosts();
  Future<bool> markAsReaded(bool isReaded, int id);
  Future<bool> isFavorite(bool isFavorite, int id);
  Future<bool> deletePost(int id);
  Future<List<Comment>> fetchPostDetails(int id);
  Future<User> fetchUserInfo(int id);
}
