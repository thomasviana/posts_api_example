import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String body;
  @HiveField(4)
  late bool isFavorite;
  @HiveField(5)
  late bool isReaded;
  @HiveField(6)
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.isFavorite,
    required this.isReaded,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
        isFavorite: false,
        isReaded: true,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
        'isFavorite': isFavorite.toString(),
        'isReaded': isReaded.toString(),
      };
}
