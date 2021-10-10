import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_api_example/cubit/post_detail_cubit.dart';
import 'package:posts_api_example/presentation/widgets/shimmer_placeholder.dart';

class PostComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text(
          'Comments',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Flexible(
          child: BlocBuilder<PostDetailCubit, PostDetailState>(
            builder: (context, state) {
              if (state is PostDetailLoadInProgress) {
                return const ShimmerPlaceHolder();
              } else if (state is PostDetailLoadSuccess) {
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final commentData = state.comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${commentData.name}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Email: ${commentData.email}',
                          style: const TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                        Text(commentData.body),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                );
              }
              return const Center(child: Text('Unespected Error'));
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
