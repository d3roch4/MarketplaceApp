import 'package:domain/entities/address.dart';
import 'package:domain/entities/chosen_product.dart';
import 'package:domain/entities/employee.dart';
import 'package:domain/entities/money.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Stream<List<T>> createParseLiveListStream<T>(
    QueryBuilder query, T objToEntity(ParseObject obj)) {
  var list = <T>[].obs;
  ParseLiveList.create(query, lazyLoading: false).then((value) {
    var newList = <T>[];
    for (var i = 0; i < value.size; i++) {
      newList.add(objToEntity(value.getLoadedAt(i)!));
    }
    list.value = newList;
  });
  return list.stream;
}

extension EmployeeJson on Employee {
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'type': type.index,
      };

  static Employee fromJson(Map<String, dynamic> json) {
    var employee = Employee(
      userId: json['userId'],
      type: EmployeeType.values[json['type']],
    );
    return employee;
  }
}

extension MoneyJson on Money {
  Map<String, dynamic> toJson() => {
        'value': value,
        'currency': currency.code,
      };

  static Money fromJson(Map<String, dynamic> json) {
    var money = Money(
      value: json['value'],
      currency: Currency.values.singleWhere((e) => e.code == json['currency']),
    );
    return money;
  }
}

extension AddressJson on Address {
  Map<String, dynamic> toJson() => {
        'zipCode': zipCode,
        'street': street,
        'ditrict': district,
        'city': city,
        'state': state,
        'coutry': coutry,
        'geoPoint': ParseGeoPoint(latitude: latitude, longitude: longitude),
      };

  static Address? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    var address = Address(
        zipCode: json['zipCode'],
        street: json['street'],
        city: json['city'],
        coutry: json['coutry'],
        district: json['district'],
        state: json['state'],
        longitude: json['longitude'],
        latitude: json['latitude']);
    return address;
  }
}

extension ChosenProductJson on ChosenProduct {
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'storeId': storeId,
        'count': count,
        'price': price.toJson(),
        'stockCheck': stockCheck,
      };

  static ChosenProduct fromJson(Map<String, dynamic> json) {
    var cp = ChosenProduct(
        productId: json['productId'],
        count: json['count'],
        price: MoneyJson.fromJson(json['price']),
        stockCheck: json['stockCheck'],
        storeId: json['storeId']);
    return cp;
  }
}
