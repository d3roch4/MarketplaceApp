import 'package:domain/entities/product.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';
import 'package:application/repository/product_repository.dart';

class ProductRepositoryMemory extends ProductRepository
    with RepositoryBaseMemory<Product> {
  @override
  Stream<List<Product>> getAllByStoreId(String storeId) {
    // TODO: implement getAllByStoreId
    throw UnimplementedError();
  }
}
