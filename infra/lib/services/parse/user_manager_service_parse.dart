import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/user.dart';
import 'package:infra/repository/parse/user_repository_parse.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:async/async.dart';

class UserManagerServiceParse extends UserManagerService {
  @override
  Future<User?> loadUser() async {
    var obj = await ParseUser.currentUser();
    if (obj == null) return null;
    current = UserRepositoryParse.objToUser(obj);
    return current!;
  }

  @override
  Future<Result<bool>> signIn(String username, String password) async {
    final user = ParseUser(username, password, null);
    var response = await user.login();
    if (!response.success) {
      if (response.error != null) {
        return Result.error(response.error!.message);
      } else {
        return Result.value(false);
      }
    }
    loadUser();
    return Result.value(true);
  }

  @override
  Future<Result<bool>> signUp(User user, String password) async {
    var userObj = ParseUser(user.username, password, user.email);
    userObj.objectId = user.id;
    userObj.set('name', user.name);
    if (user.phone != null) userObj.set('phone', user.phone);
    var result = await userObj.save();
    if (!result.success) return Result.error(result.error!.message);
    await loadUser();
    return Result.value(true);
  }

  @override
  Future<void> loggout() async {
    ParseUser obj = await ParseUser.currentUser();
    await obj.logout();
    current = null;
  }
}
