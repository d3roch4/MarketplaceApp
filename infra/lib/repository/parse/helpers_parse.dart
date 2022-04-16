import 'package:domain/entities/address.dart';
import 'package:domain/entities/chosen_product.dart';
import 'package:domain/entities/employee.dart';
import 'package:domain/entities/money.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/entities/store.dart';
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

extension ChosenProductParse on ChosenProduct {
  Map<String, dynamic> toParse() => {
        'product': (ParseObject('Product')..objectId = productId).toPointer(),
        'store': (ParseObject('Store')..objectId = storeId).toPointer(),
        'count': count,
        'price': price.toJson(),
        'stockCheck': stockCheck,
      };

  static ChosenProduct fromParse(Map<String, dynamic> json) {
    var cp = ChosenProduct(
        productId: json['product']['objectId'],
        count: json['count'],
        price: MoneyJson.fromJson(json['price']),
        stockCheck: json['stockCheck'],
        storeId: json['store']['objectId']);
    return cp;
  }
}

extension StoreParse on Store {
  static Store fromParse(ParseObject obj) {
    return Store(
      name: obj['name'],
      marketplaceId: obj['marketplaceId'],
      emailToNotifications: obj['emailToNotifications'],
      address: AddressJson.fromJson(obj['address'])!,
      id: obj.objectId,
      employees: obj['employees'].map((e)=> EmployeeJson.fromJson(e)).toList()
    );
  }
}

extension ProductParse on Product{
  void setParseObject(ParseObject obj) {
    obj.set('name', name);
    obj.set('description', description);
    obj.set('media', media);
    obj.set('stockCheck', stockCheck);
    obj.set('stockCount', stockCount);
    obj.set('price', price.toJson());
    obj.set('store', ParseObject('Store')..objectId = storeId);
  }

  static Product fromParse(ParseObject obj) {
    var product = Product(
        name: obj['name'],
        storeId: obj['store']['objectId'],
        description: obj['description']);
    product.media = (obj['media'] as List).map((e) => e.toString()).toList();
    product.stockCheck = obj['stockCheck'];
    product.price = MoneyJson.fromJson(obj['price']);
    product.stockCount = obj['stockCount'];
    product.id = obj.objectId;
    return product;
  }
}
