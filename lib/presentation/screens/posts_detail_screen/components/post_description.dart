import 'package:flutter/material.dart';
import '../../../../data/models/post.dart';

class PostDescription extends StatelessWidget {
  final Post post;
  const PostDescription({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(post.body),
        const SizedBox(height: 30),
      ],
    );
  }
}
