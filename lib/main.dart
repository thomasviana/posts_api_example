import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/cubit/post_detail_cubit.dart';
import 'features/posts/cubit/posts_cubit.dart';
import 'features/posts/cubit/segmented_control_cubit.dart';
import 'features/posts/data/datasources/network_service.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'router.dart';

void main() {
  final repository = PostsRepositoryImpl(networkService: NetworkService());
  final postsCubit = PostsCubit(repository: repository);
  final segmentedControlCubit = SegmentedControlCubit(repository, postsCubit);
  final postDetailCubit =
      PostDetailCubit(repository, postsCubit, segmentedControlCubit);

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider.value(value: postsCubit),
      BlocProvider.value(value: postDetailCubit),
      BlocProvider.value(value: segmentedControlCubit),
    ], child: PostsApp()),
  );
}

class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: AppRouter.routes,
    );
  }
}
