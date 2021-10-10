import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_list_tile.dart';

import '../../../../cubit/posts_cubit.dart';
import '../../../../data/models/post.dart';
import '../../../widgets/rounded_button.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          return PostListTile(
            posts: posts,
            index: index,
          );
        },
      ),
      Positioned(
        bottom: 40,
        //Delete All Button
        child: RoundedButton(
          onPressed: () {
            BlocProvider.of<PostsCubit>(context).clearAllPosts();
          },
        ),
      ),
    ]);
  }
}
