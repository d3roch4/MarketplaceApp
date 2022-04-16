import 'package:domain/entities/product.dart';
import 'package:domain/entities/store.dart';

class StoreProducts {
  Store store;
  List<Product> products;

  StoreProducts(this.store, this.products);
}
