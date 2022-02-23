import 'package:domain/entities/money.dart';

class ChosenProduct {
  String productId;
  String storeId;
  int count;
  Money price;
  bool physical;

  ChosenProduct(
      {required this.productId,
      required this.count,
      required this.price,
      required this.physical,
      required this.storeId});
}
