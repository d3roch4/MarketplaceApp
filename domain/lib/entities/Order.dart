import 'package:domain/entities/Address.dart';
import 'package:domain/entities/Entity.dart';
import 'package:domain/events/OrderCreateEvent.dart';

import 'ChosenProduct.dart';

class Order extends Entity {
  String cartId;
  String storeId;
  String buyerId;
  List<ChosenProduct> products;
  Address? shippingAddress;

  Order(
      {required this.cartId,
      required this.buyerId,
      required this.storeId,
      required this.shippingAddress,
      required this.products}) {
  }
}
