import 'package:application/repository/repository_base.dart';
import 'package:domain/entities/product.dart';

abstract class ProductRepository extends RepositoryBase<Product> {
  Stream<List<Product>> getAllByStoreId(String storeId);
}
