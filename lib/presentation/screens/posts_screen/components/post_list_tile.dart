import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_api_example/cubit/posts_cubit.dart';
import 'package:posts_api_example/data/models/post.dart';

class PostListTile extends StatelessWidget {
  final List<Post> posts;
  final int index;

  const PostListTile({
    Key? key,
    required this.posts,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 25),
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: Key(posts[index].id.toString()),
      child: ListTile(
        leading: posts[index].isFavorite
            ? const Icon(Icons.star_rate, color: Colors.yellow)
            : posts[index].isReaded
                ? const Icon(Icons.circle, color: Colors.transparent)
                : const Icon(Icons.circle, color: Colors.blue),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(posts[index].title),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => {
          BlocProvider.of<PostsCubit>(context).markAsReaded(posts[index]),
          Navigator.pushNamed(context, '/post_detail', arguments: posts[index]),
        },
      ),
      confirmDismiss: (_) async {
        BlocProvider.of<PostsCubit>(context).deletePost(posts[index]);
        return false;
      },
    );
  }
}
