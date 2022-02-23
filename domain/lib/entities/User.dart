import 'entity.dart';

class User extends Entity {
  String name;
  String username;
  String email;
  String? phone;

  User({required this.name, required this.username, required this.email});
}
