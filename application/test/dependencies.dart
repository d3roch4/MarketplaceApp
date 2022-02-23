import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/user.dart';
import 'package:get/get.dart';
import 'package:infra/infra.dart';
import 'package:mockito/mockito.dart';

class MockIUserManagerService extends Mock implements UserManagerService {
  User currentUser() =>
      User(name: 'name', username: 'username', email: 'email')..id = 'id';
}

void dependenciesInjection() {
  Get.create<UserManagerService>(() => MockIUserManagerService());
  Infra.useMemory();
}
