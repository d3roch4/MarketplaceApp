library application;

import 'package:application/events/create_order_whe_cart_closed.dart';
import 'package:application/marketplace/create_marketplace.dart';
import 'package:application/store/create_store_command.dart';
import 'package:application/store/get_stores_by_user_query.dart';
import 'package:application/store/last_orders_by_sotre_query.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:get/get.dart';

import 'cart/add_product_to_cart.dart';
import 'cart/payment_of_cart.dart';
import 'events/send_email_for_store_whe_cart_closed.dart';
import 'product/create_edit_product_command.dart';

class Application {
  static void registerHandles() {
    var mediator = Mediator.instance;

    Get.create(() => CreateMarketplaceHandle());
    Get.create(
        () => AddProductToCartHandle(Get.find(), Get.find(), Get.find()));
    Get.create(() => PaymentOfCartHandle(Get.find()));
    Get.create(() => SendEmailForStoreWheCartClosed(Get.find(), Get.find()));
    Get.create(() => CreateOrderWheCartClosed(Get.find(), Get.find()));
    Get.create(() => GetStoresByUserHandle(Get.find(), Get.find()));
    Get.create(() => CreateStoreHandle(Get.find(), Get.find(), Get.find()));
    Get.create(() => LastOrdersByStoreHandle());
    Get.create(() => CreateEditProductHandle(Get.find()));

    mediator.registerHandler(() => Get.find<AddProductToCartHandle>());
    mediator.registerHandler(() => Get.find<PaymentOfCartHandle>());
    mediator.registerHandler(() => Get.find<SendEmailForStoreWheCartClosed>());
    mediator.registerHandler(() => Get.find<CreateOrderWheCartClosed>());
    mediator.registerHandler(() => Get.find<GetStoresByUserHandle>());
    mediator.registerHandler(() => Get.find<CreateStoreHandle>());
    mediator.registerHandler(() => Get.find<GetStoresByUserHandle>());
    mediator.registerHandler(() => Get.find<CreateStoreHandle>());
    mediator.registerHandler(() => Get.find<LastOrdersByStoreHandle>());
    mediator.registerHandler(() => Get.find<CreateEditProductHandle>());
  }
}
