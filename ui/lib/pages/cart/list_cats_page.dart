import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:domain/services/currency_converter_service.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/cart/edit_cart_page.dart';
import 'package:turbine/pages/main_page_base.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/error_message_widget.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';

class ListCartsPage extends MainPageBase {
  CurrencyConverterService converter = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaddingWidget.future<List<Cart>>(
      future: getList(),
      builder: (list) {
        if (list == null) return ErrorMessageWidget();
        return ListView.separated(
          // padding: EdgeInsets.all(kPadding),
          itemCount: list.length,
          separatorBuilder: (c, i) => Divider(),
          itemBuilder: (c, i) {
            var cart = list[i];
            return ListTile(
              title: Text(formatDateTime.format(cart.createdAt)),
              subtitle: Text(cart.status.toStringFormatted()),
              trailing: Text(cart.totalValue(converter).toStringFormatted()),
              onTap: ()=> goToCart(cart),
            );
          },
        );
      },
    );
  }

  Future<List<Cart>> getList() {
    var user = Get.find<UserManagerService>().current!;
    return Get.find<CartRepository>().getCartsByBuyer(user.id!);
  }

  void goToCart(Cart cart) {
    if (cart.status == CartStatus.opened) Get.to(() => EditCartPage());
  }
}
