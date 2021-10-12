import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/post_detail_cubit.dart';
import '../../../widgets/shimmer_placeholder.dart';

class PostUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text(
          'User',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: BlocBuilder<PostDetailCubit, PostDetailState>(
            builder: (context, state) {
              if (state is PostDetailLoadInProgress) {
                return const ShimmerPlaceHolder();
              } else if (state is PostDetailLoadSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(height: 20),
                    Text('Name: ${state.user.name}'),
                    const SizedBox(height: 10),
                    Text('Email: ${state.user.email}'),
                    const SizedBox(height: 10),
                    Text('Phone: ${state.user.phone}'),
                    const SizedBox(height: 10),
                    Text(
                      'Website: ${state.user.webasite}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
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
