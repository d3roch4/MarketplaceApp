import 'package:application/services/user_manager_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/main_page_base.dart';

class SettingsPage extends MainPageBase {
  var userManager = Get.find<UserManagerService>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          userManager.current == null ? menuUserNotLogged() : menuUserLogged(),
    );
  }

  List<Widget> menuUserNotLogged() {
    return [
      ListTile(
        leading: Icon(Icons.login),
        title: Text("Sign in".tr),
        subtitle: Text("Is free".tr),
        onTap: signIn,
      ),
      ListTile(
        leading: Icon(Icons.app_registration),
        title: Text("Sign up".tr),
        subtitle: Text("Is free".tr),
        onTap: signUp,
      )
    ];
  }

  List<Widget> menuUserLogged() {
    return [
      ListTile(
        leading: Icon(Icons.shop),
        title: Text("Purchases".tr),
        subtitle: Text("See your purchase history".tr),
      ),
      ListTile(
        leading: Icon(Icons.store),
        title: Text("Sales".tr),
        subtitle: Text("Manager your salles".tr),
        onTap: () => Get.toNamed('/manager-stores'),
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Loggout".tr),
        onTap: loggout,
      ),
    ];
  }

  Future<void> signIn() async {
    var result = await Get.toNamed("/login/signin");
    if (result == true) setState(() {});
  }

  Future<void> signUp() async {
    var result = await Get.toNamed("/login/signup");
    if (result == true) setState(() {});
  }

  Future<void> loggout() async {
    await userManager.loggout();
    setState(() {});
  }
}
