import 'package:domain/entities/employee.dart';
import 'package:domain/entities/money.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Stream<List<T>> createParseLiveListStream<T>(QueryBuilder query, T objToEntity(ParseObject obj)){
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

  static Employee fromJson(Map<String, dynamic> json){
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

  static Money fromJson(Map<String, dynamic> json){
    var money = Money(
      value: json['value'],
      currency: Currency.values.singleWhere((e) => e.code == json['currency']),
    );
    return money;
  }
}
