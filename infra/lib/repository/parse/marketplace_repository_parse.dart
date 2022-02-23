import 'dart:async';

import 'package:application/repository/marketplace_repository.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:get/get.dart';

class MarketplaceRepositoryParse extends MarketplaceRepository {
  ParseObject get parseObject => ParseObject('Marketplace');

  @override
  Future<String> add(Marketplace entity) async {
    var obj = marketplaceToObj(entity);
    var resp = await obj.save();
    if (!resp.success)
      return Future.error(resp.error!.message, StackTrace.current);
    return entity.id = obj.objectId!;
  }

  ParseObject marketplaceToObj(Marketplace marketplace) {
    var obj = parseObject;
    obj.objectId = marketplace.id;
    obj.set('name', marketplace.name);
    obj.set('subDomain', marketplace.subDomain);
    obj.set('domains', marketplace.domains);
    return obj;
  }

  Marketplace objToMarketplace(ParseObject obj) {
    var marketplace = Marketplace(name: obj["name"], userId: obj.get("userId"));
    marketplace.id = obj.objectId;
    marketplace.domains =
        (obj["domains"] as List).map((e) => e.toString()).toList();
    marketplace.subDomain = obj["subDomain"];
    return marketplace;
  }

  @override
  Future<Marketplace?> getFirst() async {
    var queryBuilder = QueryBuilder(parseObject);
    if ((await queryBuilder.count()).count == 0) return null;
    var obj = await queryBuilder.first();
    if (obj == null) return null;
    return objToMarketplace(obj);
  }

  @override
  Future<Marketplace?> getById(String id) async {
    var obj = await parseObject.getObject(id);
    if (!obj.success) return null;
    return objToMarketplace(obj.result);
  }

  @override
  Future<void> update(Marketplace entity) async {
    await marketplaceToObj(entity).save();
  }

  @override
  Stream<List<Marketplace>> getAllMarketplacesStream() {
    var list = <Marketplace>[].obs;
    QueryBuilder query = QueryBuilder(parseObject);
    ParseLiveList.create(query, lazyLoading: false).then((value) {
      var newList = <Marketplace>[];
      for (var i = 0; i < value.size; i++) {
        newList.add(objToMarketplace(value.getLoadedAt(i)!));
      }
      list.value = newList;
    });
    return list.stream;
  }
}
