import 'dart:async';

import 'package:domain/entities/money.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:infra/repository/parse/helpers_parse.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProductRepositoryParse extends ProductRepository {
  ProductRepositoryParse(DomainEventService eventService) : super(eventService);

  ParseObject get parseObject => ParseObject('Product');

  @override
  Future<String> create(Product product) async {
    var obj = parseObject;
    product.setParseObject(obj);

    await obj.save();
    return product.id = obj.objectId!;
  }

  @override
  Future<Product?> getById(String id) async {
    var obj = await parseObject.getObject(id);
    if (obj.result != null) return ProductParse.fromParse(obj.result);
    return null;
  }

  @override
  Future<void> update(Product entity) async {
    var obj = parseObject;
    obj.objectId = entity.id;
    entity.setParseObject(obj);
    await obj.save();
  }

  @override
  Stream<List<Product>> getAllProductsByStoreId(String storeId) {
    QueryBuilder query = QueryBuilder(parseObject)
      ..whereMatchesQuery(
          'store',
          QueryBuilder(ParseObject('Store'))
            ..whereEqualTo('objectId', storeId));
    return createParseLiveListStream(query, ProductParse.fromParse);
  }

  QueryBuilder createQueryBuildTextFull(String query) {
    if (query.isEmpty) return QueryBuilder(parseObject);
    var obj = parseObject;
    return QueryBuilder.or(obj, [
      QueryBuilder(obj)..whereContainsWholeWord('name', query),
      QueryBuilder(obj)..whereContainsWholeWord('description', query),
    ]);
  }

  @override
  Stream<List<Product>> search(
      double latitude, double longitude, String query) {
    var queryBuild = QueryBuilder.or(parseObject, [
      createQueryBuildTextFull(query)
        ..whereEqualTo('stockCheck', true)
        ..whereGreaterThan('stockCount', 0),
      createQueryBuildTextFull(query)..whereNotEqualTo('stockCheck', true)
    ]);
    // queryBuild.whereMatchesQuery(
    //     'store',
    //     QueryBuilder(ParseObject('Store'))
    //       ..whereNear('address.geoPoint',
    //         ParseGeoPoint(latitude: latitude, longitude: longitude)));
    return createParseLiveListStream(queryBuild, ProductParse.fromParse);
  }
}
