class User {
  final int id;
  late String name;
  late String email;
  late String phone;
  late String webasite;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.webasite,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        webasite: json['website'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'webasite': webasite,
      };
}
