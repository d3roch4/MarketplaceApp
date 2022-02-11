import 'Entity.dart';

class User extends Entity {
  String name;
  String username;
  String email;

  User({required this.name, required this.username, required this.email});
}
