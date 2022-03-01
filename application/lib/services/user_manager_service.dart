import 'package:domain/entities/user.dart';
import 'package:async/async.dart';

abstract class UserManagerService {
  UserManagerService() {
    loadUser();
  }

  User? current;
  Future<User?> loadUser();
  Future<Result<bool>> signIn(String username, String password);
  Future<Result<bool>> signUp(User user, String password);
  Future<void> loggout();
}
