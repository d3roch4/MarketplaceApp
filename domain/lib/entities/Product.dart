import 'package:domain/entities/field.dart';

import 'entity.dart';
import 'money.dart';

class Product extends Entity {
  String name;
  String description;
  String storeId;
  Money price = Money(value: 0, currency: Currency.unknown);
  List<String> media;
  int? stockCount;
  bool stockCheck = true;
  bool available = true;
  List<Field> fields = [];

  Product({
    required this.name,
    required this.storeId,
    required this.description,
    this.media = const [],
  });
}
