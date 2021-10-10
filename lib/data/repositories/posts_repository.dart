import 'package:posts_api_example/data/models/comment.dart';
import 'package:posts_api_example/data/models/user.dart';

import '../models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> fetchPosts();
  Future<bool> markAsReaded(bool isReaded, int id);
  Future<bool> isFavorite(bool isFavorite, int id);
  Future<bool> deletePost(int id);
  Future<List<Comment>> fetchPostDetails(int id);
  Future<User> fetchUserInfo(int id);
}
