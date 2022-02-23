import 'package:application/repository/store_repository.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/entities/store.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class StoreRepositoryParse extends StoreRepository {
  ParseObject get parseObject => ParseObject('Store');

  @override
  Future<String> add(Store entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Store?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Store>> getByUser(User current) async {
    var queryBuilder = QueryBuilder(parseObject);
    queryBuilder.whereContains('employees.userId', current.id!);
    var results = await queryBuilder.find();
    return results.map((e) => objToStore(e)).toList();
  }

  @override
  Future<void> update(Store entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Store objToStore(ParseObject obj) {
    var store = Store(
        name: obj['name'],
        marketplaceId: obj['marketplaceId'],
        emailToNotifications: obj['emailToNotifications'],
        id: obj.objectId);
    return store;
  }
}
