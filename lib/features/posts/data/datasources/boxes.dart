import 'package:hive/hive.dart';

import '../models/user.dart';

class Boxes {
  static Box<List> getPosts() {
    return Hive.box<List>('posts');
  }

  static Box<List> getComments() {
    return Hive.box<List>('comments');
  }

  static Box<User> getUserInfo() {
    return Hive.box<User>('users');
  }
}
