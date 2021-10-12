// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:posts_api_example/features/posts/cubit/post_detail_cubit.dart';
// import 'package:posts_api_example/features/posts/cubit/posts_cubit.dart';
// import 'package:posts_api_example/features/posts/cubit/segmented_control_cubit.dart';
// import 'package:posts_api_example/features/posts/data/repositories/posts_repository.dart';
// import 'package:posts_api_example/features/posts/data/repositories/posts_repository_impl.dart';

// import 'features/posts/data/datasources/local_data_source.dart';
// import 'features/posts/data/datasources/remote_data_source.dart';

// // service locator
// final sl = GetIt.instance;

// Future<void> init() async {
//   //! Features - Posts
//   // Cubits
//   sl.registerFactory(() => PostsCubit(repository: sl()));
//   sl.registerFactory(
//       () => SegmentedControlCubit(repository: sl(), postsCubit: sl()));
//   sl.registerFactory(() => PostDetailCubit(
//       repository: sl(), postsCubit: sl(), segmentedControlCubit: sl()));

//   // Repository
//   sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
//         remoteDataSource: sl(),
//         localDataSource: sl(),
//       ));

//   // Data sources
//   sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
//   sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

//   //! External
//   sl.registerLazySingleton(() => http.Client());
// }
