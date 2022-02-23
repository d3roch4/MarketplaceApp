import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:turbine/utils/utils.dart';

class SignUp extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var controllerName = TextEditingController();
  var controllerPassword = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerPhone = TextEditingController();
  var loadding = false.obs;
  var userManager = Get.find<UserManagerService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome!'.tr)),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(kPadding),
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              FlutterLogo(size: 100),
              Center(
                child: Text(kAppName, style: Get.textTheme.headline4),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text('Sigup free'.tr, style: Get.textTheme.headline6),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controllerName,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Name'.tr, hintText: 'Whats your name?'.tr),
                textInputAction: TextInputAction.next,
                validator: (val) =>
                    val!.isEmpty ? 'Please, into with your name'.tr : null,
                onEditingComplete: nextFocus,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'ex: email@exemple.com'),
                textInputAction: TextInputAction.next,
                validator: (val) =>
                    !val!.contains('@') ? 'Into with your e-mail'.tr : null,
                onEditingComplete: nextFocus,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controllerPassword,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Password'.tr),
                textInputAction: TextInputAction.next,
                validator: (val) =>
                    val!.length < 2 ? 'Enter a password for access'.tr : null,
                onEditingComplete: nextFocus,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controllerPhone,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Phone'.tr, hintText: 'Contact number'.tr),
                textInputAction: TextInputAction.done,
                onEditingComplete: castrar,
              ),
              SizedBox(
                height: 16,
              ),
              Obx(() => ElevatedButton(
                    child: Text(loadding.value ? 'Loadding'.tr : 'Register'.tr),
                    onPressed: loadding.value ? null : castrar,
                  )),
            ],
          )),
    );
  }

  Future<void> castrar() async {
    if (!formKey.currentState!.validate()) return;
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final name = controllerName.text;

    loadding.value = true;
    try {
      var user = User(name: name, email: email, username: email);
      user.id = userManager.current?.id;
      var result = await userManager.signUp(user, password);
      if (result.isValue && result.asValue?.value == true) {
        result = await userManager.signIn(email, password);
        if (!result.isError) return Get.back(result: true);
      }
      errorSnack(result.asError!.error.toString().tr);
    } catch (ex, st) {
      errorSnack(ex.toString().tr, st);
    }
    loadding.value = false;
  }
}
