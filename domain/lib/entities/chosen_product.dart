import 'package:domain/entities/money.dart';

class ChosenProduct {
  String productId;
  String storeId;
  int count;
  Money price;
  bool stockCheck;

  ChosenProduct(
      {required this.productId,
      required this.count,
      required this.price,
      required this.stockCheck,
      required this.storeId});
}
