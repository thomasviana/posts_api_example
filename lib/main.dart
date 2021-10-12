import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/posts/data/datasources/local_data_source.dart';
import 'features/posts/data/datasources/remote_data_source.dart';
import 'features/posts/data/models/comment.dart';
import 'features/posts/data/models/post.dart';
import 'features/posts/cubit/post_detail_cubit.dart';
import 'features/posts/cubit/posts_cubit.dart';
import 'features/posts/cubit/segmented_control_cubit.dart';
import 'features/posts/data/models/user.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = PostsRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(),
      localDataSource: LocalDataSourceImpl());
  final postsCubit = PostsCubit(repository);
  final segmentedControlCubit = SegmentedControlCubit(repository, postsCubit);
  final postDetailCubit =
      PostDetailCubit(repository, postsCubit, segmentedControlCubit);

  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<List>('posts');
  await Hive.openBox<List>('comments');
  await Hive.openBox<User>('users');

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider.value(value: postsCubit),
      BlocProvider.value(value: postDetailCubit),
      BlocProvider.value(value: segmentedControlCubit),
    ], child: PostsApp()),
  );
}

class PostsApp extends StatefulWidget {
  @override
  State<PostsApp> createState() => _PostsAppState();
}

class _PostsAppState extends State<PostsApp> {
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

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
