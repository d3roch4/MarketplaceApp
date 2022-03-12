import 'package:domain/entities/address.dart';
import 'package:domain/entities/currency.dart';
import 'package:domain/entities/entity.dart';
import 'package:domain/entities/money.dart';
import 'package:domain/events/order_create_event.dart';
import 'package:domain/services/currency_converter_service.dart';

import 'chosen_product.dart';

class Order extends Entity {
  String cartId;
  String storeId;
  String buyerId;
  List<ChosenProduct> products;
  Address? shippingAddress;
  StatusOrder status;

  Order(
      {required this.cartId,
      required this.buyerId,
      required this.storeId,
      required this.shippingAddress,
      required this.products,
      this.status = StatusOrder.unknown});

  Money totalValue(CurrencyConverterService converter,
      [Currency currency = Currency.ethereum]) {
    double result = 0;
    for (var p in products) result += converter.to(p.price, currency).value;
    return Money(value: result, currency: currency);
  }
}

enum StatusOrder {
  unknown,
  waitingForSeller,
  rejected,
  processing,
  canceled,
}
