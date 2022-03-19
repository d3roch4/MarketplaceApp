import 'package:application/services/location_search_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/address.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:get/get.dart';

class ListNearbyProductsQuery extends IQuery<Stream<List<Product>>> {
  double latitude;
  double longitude;
  String query;

  ListNearbyProductsQuery(
      [this.latitude = -1, this.longitude = -1, this.query = '']);
}

class ListNearbyProductsHandle
    extends IQueryHandler<Stream<List<Product>>, ListNearbyProductsQuery> {
  ProductRepository productRepository;
  LocationSearchService locationSearchService;

  ListNearbyProductsHandle(this.productRepository, this.locationSearchService);

  @override
  Stream<List<Product>> call(ListNearbyProductsQuery command) async* {
    if (command.latitude < 0 || command.longitude < 0) {
      var address = await locationSearchService.getCurrentAddress();
      if (address != null) {
        command.latitude = address.latitude;
        command.longitude = address.longitude;
      }
    }
    if (command.latitude < 0 || command.longitude < 0)
      throw AssertionError('Location invalid');

    yield* productRepository.search(
        command.latitude, command.longitude, command.query);
  }
}
