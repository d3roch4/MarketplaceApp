import 'package:application/application.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:infra/infra.dart';
import 'package:get/get.dart';

Future<void> configureApp() async {
  await Infra.useParse();
  Application.registerHandles();
  await Get.find<UserManagerService>().loadUser();
}
