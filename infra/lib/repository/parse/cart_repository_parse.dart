import 'package:domain/entities/address.dart';
import 'package:domain/entities/chosen_product.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/model/cart_stores_products.dart';
import 'package:domain/model/store_products.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:domain/repository/store_repository.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'helpers_parse.dart';

class CartRepositoryParse extends CartRepository {
  ParseObject get parseObject => ParseObject('Cart');
  StoreRepository storeRepository;
  ProductRepository productRepository;

  CartRepositoryParse(DomainEventService eventService, this.storeRepository,
      this.productRepository)
      : super(eventService);

  ParseObject cartToObj(Cart cart) {
    var obj = parseObject;
    obj.set('buyer', ParseObject('_User')..objectId = cart.buyerId);
    obj.set('products', cart.products.map((e) => e.toParse()).toList());
    obj.set('status', cart.status.index);
    obj.set('shippingAddress', cart.shippingAddress);
    obj.objectId = cart.id;
    return obj;
  }

  Cart objToCart(ParseObject obj) {
    var cart = Cart(buyerId: obj['buyer']["objectId"]);
    cart.products = (obj['products'] as List)
        .map<ChosenProduct>((e) => ChosenProductParse.fromParse(e))
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
    query.whereEqualTo('buyer', ParseUser.forQuery()..objectId = user.id);
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

  @override
  Future<CartStoresProducts> getCartStoresProductsByCart(String cartId) async {
    var query = QueryBuilder(parseObject);
    query.whereEqualTo('objectId', cartId);
    query.includeObject(['products.product', 'products.sotre']);
    var result = await query.find();
    if (result.isEmpty) throw Exception('Cart not found');

    var mapStoreProducts = <String, StoreProducts>{};
    var products = result.first['products'];// as List<Map<String, dynamic>>;
    var productsChosen = <ChosenProduct>[];

    for (var cp in products) {
      var store = cp['store'] as ParseObject;
      var storeProducts = mapStoreProducts[store.objectId];
      if (storeProducts == null) {
        var store_ = await storeRepository.getById(store.objectId!);
        var futures = products
            .where((e) => e['store']['objectId'] == store_!.id)
            .map<Future<Product>>((e) async => (await productRepository
                .getById((e['product'] as ParseObject).objectId!))!);
        var products_ = await Future.wait<Product>(futures);
        mapStoreProducts[store_!.id!] =
            storeProducts = StoreProducts(store_, products_);
      }
    }
    var cartStoreProducts = CartStoresProducts(
        objToCart(result.first), mapStoreProducts.values.toList());
    return cartStoreProducts;
  }

  @override
  Future<List<Cart>> getCartsByBuyer(String buyerId) async {
    var query = QueryBuilder(parseObject);
    query.whereEqualTo('buyer', ParseUser.forQuery()..objectId = buyerId);
    query.orderByAscending('status');
    var result = await query.find();
    return result.map((e) => objToCart(e)).toList();
  }
}
