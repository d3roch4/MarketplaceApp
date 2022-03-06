import 'package:domain/entities/product.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';
import 'package:domain/repository/product_repository.dart';

class ProductRepositoryMemory extends RepositoryBaseMemory<Product>
    implements ProductRepository {
  ProductRepositoryMemory(DomainEventService eventService) : super(eventService);

  @override
  Stream<List<Product>> getAllProductsByStoreId(String storeId) {
    // TODO: implement getAllByStoreId
    throw UnimplementedError();
  }
}
