import 'package:application/cart/AddProductToCart.dart';
import 'package:application/cart/PaymentOfCart.dart';
import 'package:application/events/SendEmailForStoreWheCartClosed.dart';
import 'package:application/repository/CartRepository.dart';
import 'package:application/repository/OrderRepository.dart';
import 'package:application/repository/ProductRepository.dart';
import 'package:application/repository/StoreRepository.dart';
import 'package:application/services/IUserManagerService.dart';
import 'package:domain/entities/User.dart';
import 'package:get/get.dart';
import 'package:infra/repository/memory/CartRepositoryMemory.dart';
import 'package:infra/repository/memory/StoreRepositoryMemory.dart';
import 'package:infra/repository/memory/ProductRepositoryMemory.dart';
import 'package:infra/repository/memory/OrderRepositoryMemory.dart';
import 'package:mockito/mockito.dart';

class MockIUserManagerService extends Mock implements IUserManagerService {
  User currentUser() =>
      User(name: 'name', username: 'username', email: 'email')..id = 'id';
}

void dependenciesInjection() {
  Get.create<IUserManagerService>(() => MockIUserManagerService());
  Get.lazyPut<CartRepository>(() => CartRepositoryMemory());
  Get.lazyPut<StoreRepository>(() => StoreRepositoryMemory());
  Get.lazyPut<ProductRepository>(() => ProductRepositoryMemory());
  Get.lazyPut<OrderRepository>(() => OrderRepositoryMemory());
}


