class Post {
  final int userId;
  final int id;
  late String title;
  late String body;
  late bool isFavorite;
  late bool isReaded;

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
      };
}
