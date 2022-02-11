library application;

import 'package:application/events/CreateOrderWheCartClosed.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:get/get.dart';

import 'cart/AddProductToCart.dart';
import 'cart/PaymentOfCart.dart';
import 'events/SendEmailForStoreWheCartClosed.dart';

class Application {
  static void registerHandles() {
    var mediator = Mediator.instance;

    Get.create(() => AddProductToCartHandle(Get.find(), Get.find(), Get.find()));
    Get.create(() => PaymentOfCartHandle(Get.find()));
    Get.create(() => SendEmailForStoreWheCartClosed(Get.find(), Get.find()));
    Get.create(() => CreateOrderWheCartClosed(Get.find(), Get.find()));

    mediator.registerHandler(()=> Get.find<AddProductToCartHandle>());
    mediator.registerHandler(()=> Get.find<PaymentOfCartHandle>());
    mediator.registerHandler(()=> Get.find<SendEmailForStoreWheCartClosed>());
    mediator.registerHandler(()=> Get.find<CreateOrderWheCartClosed>());
  }
}
