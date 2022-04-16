import 'package:domain/model/cart_stores_products.dart';
import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class CartRepository extends RepositoryBase<Cart> {
  CartRepository(DomainEventService eventService) : super(eventService);

  Future<Cart> getOpenedOrNew(User user) async {
    var cart = await findOpenedByUser(user);
    if (cart != null) return cart;

    cart = Cart(buyerId: user.id!);
    cart.status = CartStatus.opened;
    await save(cart);
    return cart;
  }

  Future<Cart?> findOpenedByUser(User user);

  Future<CartStoresProducts> getCartStoresProductsByCart(String cartId);

  Future<List<Cart>> getCartsByBuyer(String buyerId);
}
