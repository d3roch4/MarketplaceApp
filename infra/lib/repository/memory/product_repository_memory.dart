import 'package:domain/entities/product.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';
import 'package:application/repository/product_repository.dart';

class ProductRepositoryMemory extends RepositoryBaseMemory<Product> implements ProductRepository{
  @override
  Stream<List<Product>> getAllByStoreId(String storeId) {
    // TODO: implement getAllByStoreId
    throw UnimplementedError();
  }
}
