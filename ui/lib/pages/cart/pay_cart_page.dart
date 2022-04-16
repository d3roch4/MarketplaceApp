import 'package:domain/entities/currency.dart';
import 'package:domain/entities/wallet.dart';
import 'package:domain/model/cart_stores_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/create_botton_app_bar.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:domain/repository/wallet_repository.dart';

class PayCartPage extends StatelessWidget {
  var wallet = Rx<Wallet?>(null);
  CartStoresProducts cartStoresProducts;

  PayCartPage(this.cartStoresProducts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getDropDownWallets(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Pay'.tr),
        onPressed: payCart,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomSheet: createBottomAppBar(Text(
          cartStoresProducts.cart
              .totalValue(Get.find(), Currency.ethereum)
              .toStringFormatted(),
          style: Get.textTheme.headline6)),
    );
  }

  Widget getDropDownWallets() {
    return LoaddingWidget.future<List<Wallet>>(
        future: Get.find<WalletRepository>().listAll(),
        builder: (list) {
          if (list == null) return CircularProgressIndicator();
          if (list.isEmpty) return createWallet();
          return Obx(() => DropdownButton<Wallet>(
                items: list
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        ))
                    .toList(),
                onChanged: (v) => wallet.value = v,
                value: wallet.value,
              ));
        });
  }

  Widget createWallet() {
    return OutlinedButton(
      child: Text('Create wallet'.tr),
      onPressed: () => Get.toNamed('/wallets/create'),
    );
  }

  void payCart() {
    wallet.value?.pay(cartStoresProducts.cart);
  }
}
