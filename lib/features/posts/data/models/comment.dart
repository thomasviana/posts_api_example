import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 1)
class Comment extends HiveObject {
  @HiveField(0)
  final int postId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}
