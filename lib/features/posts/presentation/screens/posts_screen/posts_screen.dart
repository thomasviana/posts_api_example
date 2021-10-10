import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/posts_cubit.dart';
import '../../../cubit/segmented_control_cubit.dart';
import '../../widgets/shimmer_placeholder.dart';

import 'components/posts_list.dart';
import 'components/segmented_control.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).fetchPosts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<PostsCubit>(context).fetchPosts();
              BlocProvider.of<SegmentedControlCubit>(context).reset();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedControl(),
          const SizedBox(height: 30),
          Expanded(
            child: BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                if (state is PostsLoadInProgress) {
                  return ListView.separated(
                    itemCount: 100,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 1),
                    itemBuilder: (BuildContext context, int index) {
                      return const ShimmerPlaceHolder();
                    },
                  );
                } else if (state is PostsInitial) {
                  return const Center(
                    child: Text('No Posts'),
                  );
                } else if (state is PostsLoadSuccess) {
                  final posts = state.posts;
                  return PostsList(posts: posts);
                }
                return const Text('Unespected error');
              },
            ),
          ),
        ],
      ),
    );
  }
}
