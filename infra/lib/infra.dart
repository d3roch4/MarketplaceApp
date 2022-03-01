library infra;

import 'package:application/services/user_manager_service.dart';
import 'package:domain/events/domain_event.dart';
import 'package:get/get.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:domain/repository/order_repository.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:domain/repository/store_repository.dart';
import 'package:domain/repository/marketplace_repository.dart';
import 'package:application/services/marketplace_manager_service.dart';
import 'package:infra/repository/memory/cart_repository_memory.dart';
import 'package:infra/repository/memory/order_repository_memory.dart';
import 'package:infra/repository/memory/product_repository_memory.dart';
import 'package:infra/repository/memory/store_repository_memory.dart';
import 'package:infra/repository/parse/marketplace_repository_parse.dart';
import 'package:infra/repository/parse/product_repository_parse.dart';
import 'package:infra/repository/parse/store_repository_parse.dart';
import 'package:infra/services/parse/market_place_manager_service_parse.dart';
import 'package:infra/services/parse/user_manager_service_parse.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:application/services/domain_event_service.dart';
import 'package:domain/services/domain_event_service.dart';

class Infra {
  static Future<void> useParse() async {
    await Parse().initialize(
      'aqRHIxxwwYMu9yCRwEkr2UPXlFjgdSOP6n0YLcFa',
      'https://parseapi.back4app.com',
      clientKey:
          'dAJRi5lWvNoU26d6DoMzFAHEJvxdhmfOHUIslMuX', // Required for some setups
      coreStore: await CoreStoreSembastImp.getInstance(),
      debug: true, // When enabled, prints logs to console
      liveQueryUrl: 'wss://turbine.b4ap.app', // Required if using LiveQuery
      autoSendSessionId: true, // Required for authentication and ACL
    );
    Get.create<StoreRepository>(() => StoreRepositoryParse(Get.find()));
    Get.create<MarketplaceRepository>(() => MarketplaceRepositoryParse(Get.find()));
    Get.create<ProductRepository>(() => ProductRepositoryParse(Get.find()));
    Get.create<DomainEventService>(() => ApplicationEventService());
    Get.lazyPut<MarketplaceManagerService>(
        () => MarketplaceManagerServiceParse(Get.find()));
    Get.lazyPut<UserManagerService>(() => UserManagerServiceParse());
  }

  static void useMemory() {
    Get.lazyPut<CartRepository>(() => CartRepositoryMemory(Get.find()));
    Get.lazyPut<StoreRepository>(() => StoreRepositoryMemory(Get.find()));
    Get.lazyPut<ProductRepository>(() => ProductRepositoryMemory(Get.find()));
    Get.lazyPut<OrderRepository>(() => OrderRepositoryMemory(Get.find()));
  }
}
