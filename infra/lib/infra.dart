library infra;

import 'package:application/services/user_manager_service.dart';
import 'package:get/get.dart';
import 'package:application/repository/cart_repository.dart';
import 'package:application/repository/order_repository.dart';
import 'package:application/repository/product_repository.dart';
import 'package:application/repository/store_repository.dart';
import 'package:application/repository/marketplace_repository.dart';
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
    Get.create<StoreRepository>(() => StoreRepositoryParse());
    Get.create<MarketplaceRepository>(() => MarketplaceRepositoryParse());
    Get.create<ProductRepository>(() => ProductRepositoryParse());
    Get.lazyPut<MarketplaceManagerService>(()=>
        MarketplaceManagerServiceParse(Get.find()));
    Get.lazyPut<UserManagerService>(()=> UserManagerServiceParse());
  }

  static void useMemory() {
    Get.lazyPut<CartRepository>(() => CartRepositoryMemory());
    Get.lazyPut<StoreRepository>(() => StoreRepositoryMemory());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryMemory());
    Get.lazyPut<OrderRepository>(() => OrderRepositoryMemory());
  }
}
