import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/address.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/entities/currency.dart';
import 'package:domain/model/cart_stores_products.dart';
import 'package:domain/model/store_products.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/create_botton_app_bar.dart';

class EditCartPage extends StatelessWidget {
  CartStoresProducts? cartStoresProducts;

  @override
  Widget build(BuildContext context) {
    return LoaddingPage.future<CartStoresProducts>(
        future: loaddingCartStoresProducts(),
        initialData: cartStoresProducts,
        builder: (cartStoresProducts) {
          this.cartStoresProducts = cartStoresProducts;
          if (cartStoresProducts == null)
            return Center(child: CircularProgressIndicator());
          return Scaffold(
            appBar: AppBar(
              title: Text("Cart opened".tr),
            ),
            body: ListView(
              padding: EdgeInsets.all(kPadding),
              children: [
                for (var storeProduto in cartStoresProducts.storesProducts)
                  Card(
                      child: Column(children: [
                    Text(storeProduto.store.name),
                    for (var i = 0; i < storeProduto.products.length; i++)
                      createTileProduct(cartStoresProducts, storeProduto, i)
                  ])),
                ListTile(
                  leading: Icon(Icons.map),
                  title: getAddressToShipping(),
                  subtitle: Text('Change address to shipping'),
                  onTap: changeAddress,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text('Buy'.tr),
              onPressed: closeCart,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomSheet: createBottomAppBar(Text(
                cartStoresProducts.cart
                    .totalValue(Get.find(), Currency.ethereum)
                    .toStringFormatted(),
                style: Get.textTheme.headline6)),
          );
        });
  }

  Future<Cart> loadderCart() async {
    var user = Get.find<UserManagerService>().current;
    return Get.find<CartRepository>().getOpenedOrNew(user!);
  }

  Future<CartStoresProducts> loaddingCartStoresProducts() async {
    Cart cart = Get.arguments ?? await loadderCart();
    return Get.find<CartRepository>().getCartStoresProductsByCart(cart.id!);
  }

  Widget createTileProduct(CartStoresProducts cartStoresProducts,
      StoreProducts storeProducts, int i) {
    var product = storeProducts.products[i];
    var chosenProduct = cartStoresProducts.cart.products
        .firstWhere((e) => e.productId == product.id);

    return ListTile(
      leading: Text(chosenProduct.count.toString()),
      title: Text(product.name.tr),
      trailing: Text(chosenProduct.price.toStringFormatted()),
    );
  }

  Widget getAddressToShipping() {
    var address = Address(
        city: 'Serra Dourada',
        coutry: 'Brasil',
        state: 'BA',
        street: 'Rua da Pedras',
        district: 'Centro',
        zipCode: '47740-000',
        latitude: -41,
        longitude: 21);
    return Text(address.toString());
  }

  void changeAddress() {}

  void closeCart() {}
}
