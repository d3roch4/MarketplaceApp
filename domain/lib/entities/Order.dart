import 'package:domain/entities/address.dart';
import 'package:domain/entities/entity.dart';
import 'package:domain/events/order_create_event.dart';

import 'chosen_product.dart';

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
