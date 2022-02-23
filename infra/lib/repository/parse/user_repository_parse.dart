import 'dart:async';

import 'package:application/repository/user_repository.dart';
import 'package:domain/entities/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepositoryParse extends UserRepository {
  static User objToUser(ParseObject obj) {
    var user =
        User(name: obj['name'], username: obj['username'], email: obj['email']);
    user.id = obj.objectId;
    return user;
  }

  @override
  Future<String> add(User entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<User?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> update(User entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
