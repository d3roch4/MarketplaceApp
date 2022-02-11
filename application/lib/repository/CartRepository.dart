import 'package:application/repository/RepositoryBase.dart';
import 'package:domain/entities/Cart.dart';
import 'package:domain/entities/User.dart';

abstract class CartRepository extends RepositoryBase<Cart> {
  Future<Cart> getOpenedOrNew(User user) async {
    var cart = await findOpenedByUser(user);
    if (cart != null) return cart;

    cart = Cart(buyerId: user.id!);
    cart.status = CartStatus.opened;
    await save(cart);
    return cart;
  }

  Future<Cart?> findOpenedByUser(User user);
}
