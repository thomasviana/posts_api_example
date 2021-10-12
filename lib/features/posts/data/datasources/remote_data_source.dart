import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';

abstract class RemoteDataSource {
  Future<List<Post>> fetchPosts();
  Future<List<Comment>> fetchPostComments(int id);
  Future<User> fetchUserInfo(int id);
  Future<bool> patchPost(Map<String, String> patchObj, int id);
  Future<bool> deletePost(int id);
  Future<bool> deleteAllPosts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final postsUrl = 'https://jsonplaceholder.typicode.com/posts';
  final usersUrl = 'https://jsonplaceholder.typicode.com/users';

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(postsUrl));
      final parsed = jsonDecode(response.body) as List;
      final remotePosts = parsed.map((e) => Post.fromJson(e)).toList();
      return remotePosts;
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  @override
  Future<List<Comment>> fetchPostComments(int id) async {
    try {
      final response = await http.get(Uri.parse(postsUrl + '/$id/comments'));
      final parsed = jsonDecode(response.body) as List;
      final remoteComments = parsed.map((e) => Comment.fromJson(e)).toList();
      return remoteComments;
    } catch (error) {
      throw Exception('Error getting post comments: $error');
    }
  }

  @override
  Future<User> fetchUserInfo(int id) async {
    try {
      final response = await http.get(Uri.parse(usersUrl + '/$id'));
      final parsed = jsonDecode(response.body);
      final remoteUser = User.fromJson(parsed);
      return remoteUser;
    } catch (error) {
      throw Exception('Error getting user info: $error');
    }
  }

  @override
  Future<bool> patchPost(Map<String, String> patchObj, int id) async {
    try {
      await http.patch(
        Uri.parse(postsUrl + '/$id'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patchObj),
      );
      return true;
    } catch (error) {
      throw Exception('Error patching post: $error');
    }
  }

  @override
  Future<bool> deletePost(int id) async {
    try {
      await http.delete(Uri.parse(postsUrl + '/$id'));
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllPosts() async {
    try {
      await http.delete(Uri.parse(postsUrl));
      return true;
    } catch (error) {
      return false;
    }
  }
}
