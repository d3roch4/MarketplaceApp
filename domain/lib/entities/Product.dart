import 'entity.dart';
import 'money.dart';

class Product extends Entity {
  String name;
  String description;
  String storeId;
  Money price = Money(value: 0, currency: Currencies.unknown);
  List<String> media = [];
  int stockCount;
  bool physical = true;

  Product({
    required this.name,
    required this.storeId,
    required this.description,
    this.stockCount = 0,
  });
}
