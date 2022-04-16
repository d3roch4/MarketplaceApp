import 'package:domain/entities/cart.dart';
import 'package:domain/model/store_products.dart';

class CartStoresProducts {
  Cart cart;
  List<StoreProducts> storesProducts;

  CartStoresProducts(this.cart, this.storesProducts);
}
