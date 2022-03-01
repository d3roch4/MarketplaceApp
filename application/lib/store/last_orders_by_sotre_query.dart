import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/order.dart';
import 'package:domain/entities/user.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrderBuyer {
  Order order;
  User buyer;
  OrderBuyer(this.order, this.buyer);
}

class LastOrdersByStoreQuery extends IAsyncQuery<List<OrderBuyer>> {
  String sotreId;
  LastOrdersByStoreQuery(this.sotreId);
}

class LastOrdersByStoreHandle
    extends IAsyncQueryHandler<List<OrderBuyer>, LastOrdersByStoreQuery> {
  @override
  Future<List<OrderBuyer>> call(LastOrdersByStoreQuery command) async {
    return [];
  }

}
