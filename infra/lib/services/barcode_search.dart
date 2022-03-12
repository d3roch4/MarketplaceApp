import 'dart:convert';

import 'package:application/product/create_edit_product_command.dart';
import 'package:domain/entities/field.dart';
import 'package:domain/entities/money.dart';
import 'package:http/http.dart' as http;

abstract class BarcodeSearch {
  Future<CreateEditProductCommand?> serach(String code);
}

class BarcodeSearchCosmos extends BarcodeSearch {
  @override
  Future<CreateEditProductCommand?> serach(String code) async {
    var resp = await http.get(
        Uri.parse('https://api.cosmos.bluesoft.com.br/gtins/$code.json'),
        headers: {"X-Cosmos-Token": "zOTgDjin6yZkGXBErIrlwg"});
    if (resp.statusCode != 200) return null;
    
    var dataApi = json.decode(resp.body);
    var result = CreateEditProductCommand();
    result.price =
        Money(value: dataApi['avg_price'] as double, currency: Currency.real);
    result.name = dataApi['description'];
    var marca = dataApi['brand'];
    if (marca != null)
      result.fields.add(Field<String>(name: "brand", value: marca['name']));
    if (dataApi['ncm'] != null)
      result.fields.add(Field<String>(name: "ncm", value: dataApi['ncm']['code']));

    return result;
  }
}
