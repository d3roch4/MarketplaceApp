import 'package:domain/entities/address.dart';
import 'package:domain/entities/chosen_product.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'helpers_parse.dart';

class CartRepositoryParse extends CartRepository {
  ParseObject get parseObject => ParseObject('Cart');

  CartRepositoryParse(DomainEventService eventService) : super(eventService);

  ParseObject cartToObj(Cart cart) {
    var obj = parseObject;
    obj.set('buyerId', cart.buyerId);
    obj.set('products', cart.products.map((e) => e.toJson()).toList());
    obj.set('status', cart.status.index);
    obj.set('shippingAddress', cart.shippingAddress);
    obj.objectId = cart.id;
    return obj;
  }

  Cart objToCart(ParseObject obj) {
    var cart = Cart(buyerId: obj['buyerId']);
    cart.products = (obj['products'] as List)
        .map<ChosenProduct>((e) => ChosenProductJson.fromJson(e))
        .toList();
    cart.shippingAddress = AddressJson.fromJson(obj['shippingAddress']);
    cart.status = CartStatus.values[obj['status']];
    cart.id = obj.objectId;
    cart.createdAt = obj.createdAt!;
    cart.modifiedAt = obj.updatedAt;
    return cart;
  }

  @override
  Future<String> create(Cart cart) async {
    var obj = cartToObj(cart);
    await obj.save();
    return (cart.id = obj.objectId)!;
  }

  @override
  Future<Cart?> findOpenedByUser(User user) async {
    var query = QueryBuilder(parseObject);
    query.whereEqualTo('buyerId', user.id);
    query.whereEqualTo('status', CartStatus.opened.index);
    var result = await query.find();
    if (result.isEmpty) return null;
    return objToCart(result.first);
  }

  @override
  Future<Cart?> getById(String id) async {
    var obj = await parseObject.get(id);
    if (obj == null) return null;
    return objToCart(obj);
  }

  @override
  Future<void> update(Cart cart) async {
    var obj = cartToObj(cart);
    await obj.save();
  }
}
