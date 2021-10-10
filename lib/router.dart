import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/posts/data/models/post.dart';
import 'features/posts/presentation/screens/posts_detail_screen/post_detail_screen.dart';
import 'features/posts/presentation/screens/posts_screen/posts_screen.dart';

class AppRouter {
  static const posts = '/';
  static const postDetail = '/post_detail';

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case posts:
        return _buildRoute(PostsScreen());

      case postDetail:
        final post = settings.arguments as Post;
        return _buildRoute(PostDetailScreen(
          post: post,
        ));

      default:
        throw ('This raoute name does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
