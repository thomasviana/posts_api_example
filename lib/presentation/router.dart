import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/segmented_control_cubit.dart';
import '../data/repositories/posts_repository_impl.dart';

import '../cubit/post_detail_cubit.dart';
import '../cubit/posts_cubit.dart';
import '../data/models/post.dart';
import '../data/datasources/network_service.dart';
import 'screens/posts_detail_screen/post_detail_screen.dart';
import 'screens/posts_screen/posts_screen.dart';

class AppRouter {
  late PostsRepositoryImpl repository;
  late PostsCubit postsCubit;
  late SegmentedControlCubit segmentedControlCubit;

  AppRouter() {
    repository = PostsRepositoryImpl(networkService: NetworkService());
    postsCubit = PostsCubit(repository: repository);
    segmentedControlCubit = SegmentedControlCubit(repository, postsCubit);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: postsCubit,
              ),
              BlocProvider.value(
                value: segmentedControlCubit,
              ),
            ],
            child: PostsScreen(),
          ),
        );
      case '/post_detail':
        final post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => PostDetailCubit(
              repository,
              postsCubit,
              segmentedControlCubit,
            ),
            child: PostDetailScreen(
              post: post,
            ),
          ),
        );

      default:
        throw ('This raoute name does not exist');
    }
  }
}
