import 'package:flutter/material.dart';
import 'presentation/router.dart';

void main() {
  runApp(
    PostsApp(
      router: AppRouter(),
    ),
  );
}

class PostsApp extends StatelessWidget {
  final AppRouter router;

  const PostsApp({
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
