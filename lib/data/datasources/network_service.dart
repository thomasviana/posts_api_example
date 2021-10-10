import 'dart:convert';

import 'package:http/http.dart';

class NetworkService {
  final postsUrl = 'https://jsonplaceholder.typicode.com/posts';
  final usersUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await get(Uri.parse(postsUrl));
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> fetchPostComments(int id) async {
    try {
      final response = await get(Uri.parse(postsUrl + '/$id/comments'));
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchUserInfo(int id) async {
    try {
      final response = await get(Uri.parse(usersUrl + '/$id'));
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> patchpost(Map<String, String> patchObj, int id) async {
    try {
      await patch(Uri.parse(postsUrl + '/$id'), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      await delete(Uri.parse(postsUrl + '/$id'));
      return true;
    } catch (er) {
      return false;
    }
  }
}
