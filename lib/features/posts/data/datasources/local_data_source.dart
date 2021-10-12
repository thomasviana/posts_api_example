import 'boxes.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';

abstract class LocalDataSource {
  Future<void>? cacheAllPosts(List<Post> allPosts);
  Future<void>? cacheAllComments(List<Comment> allComments, int id);
  Future<void>? cacheAllUserInfo(User user, int id);
  List<Post>? getCachedPosts();
  List<Comment>? getCachedComments(int id);
  User? getCachedUserInfo(int id);
  void markAsReaded(Post post);
  void isFavorite(Post post);
  void deletePost(int id);
  void deleteAllPosts();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void>? cacheAllPosts(List<Post> allPosts) async {
    final box = Boxes.getPosts();
    box.put('ALL_POSTS', allPosts);
  }

  @override
  List<Post>? getCachedPosts() {
    final box = Boxes.getPosts();
    final cachedPosts = box.get('ALL_POSTS', defaultValue: [])!.cast<Post>();
    return cachedPosts;
  }

  @override
  Future<void>? cacheAllComments(List<Comment> allComments, int id) {
    final box = Boxes.getComments();
    box.put('ALL_COMMENTS_FOR_$id', allComments);
  }

  @override
  List<Comment> getCachedComments(id) {
    final box = Boxes.getComments();
    final cachedComments =
        box.get('ALL_COMMENTS_FOR_$id', defaultValue: [])!.cast<Comment>();
    return cachedComments;
  }

  @override
  Future<void>? cacheAllUserInfo(User user, int id) {
    final box = Boxes.getUserInfo();
    box.put('USER_$id', user);
  }

  @override
  User? getCachedUserInfo(int id) {
    final box = Boxes.getUserInfo();
    final cachedUser = box.get('USER_$id');
    return cachedUser;
  }

  @override
  void markAsReaded(Post post) async {
    final box = Boxes.getPosts();
    final postsUpdated = getCachedPosts()!;
    post.isReaded = true;
    box.put('ALL_POSTS', postsUpdated);
  }

  @override
  void isFavorite(Post post) {
    final box = Boxes.getPosts();
    final postsUpdated = getCachedPosts()!;
    post.isFavorite = !post.isFavorite;
    box.put('ALL_POSTS', postsUpdated);
  }

  @override
  void deletePost(int id) {
    final box = Boxes.getPosts();
    final postsUpdated = getCachedPosts()!;
    postsUpdated.removeWhere((post) => post.id == id);
    box.put('ALL_POSTS', postsUpdated);
  }

  @override
  Future<void>? deleteAllPosts() {
    final box = Boxes.getPosts();
    box.clear();
  }
}
