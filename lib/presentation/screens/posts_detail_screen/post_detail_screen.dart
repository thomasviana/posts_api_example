import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/posts_cubit.dart';
import '../../../cubit/post_detail_cubit.dart';
import '../../../data/models/post.dart';

import 'components/post_comments.dart';
import 'components/post_description.dart';
import 'components/post_user_info.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostDetailCubit>(context).fetchPostDetails(post);

    return BlocBuilder<PostDetailCubit, PostDetailState>(
      builder: (context, state) {
        if (state is PostDetailLoadSuccess) {
          final _postEdited = state.post;
          buildContent(context, _postEdited);
        }
        return buildContent(context, post);
      },
    );
  }

  Scaffold buildContent(BuildContext context, Post post) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post'), actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<PostDetailCubit>(context).isFavorite(post);
          },
          icon: post.isFavorite
              ? const Icon(Icons.star_rate)
              : const Icon(Icons.star_outline),
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostDescription(post: post),
              PostUserInfo(),
              Flexible(child: PostComments()),
            ],
          ),
        ),
      ),
    );
  }
}
