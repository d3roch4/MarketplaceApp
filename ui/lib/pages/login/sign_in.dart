import 'package:application/services/user_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:turbine/utils/utils.dart';

class SignIn extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  var loadding = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in'.tr)),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(kPadding),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              FlutterLogo(size: 100),
              Center(
                child: Text(kAppName, style: Get.textTheme.headline3),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text('Enter your email and password or sign up'.tr,
                    style: Get.textTheme.headline5),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'ex: email@exemple.com'),
                textInputAction: TextInputAction.newline,
                validator: (val) =>
                    !val!.contains('@') ? 'Is your email correct?'.tr : null,
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
                textInputAction: TextInputAction.newline,
                validator: (val) => val!.length < 2
                    ? 'Please enter a longer password'.tr
                    : null,
                onEditingComplete: sigin,
              ),
              SizedBox(
                height: 16,
              ),
              Obx(() => ElevatedButton(
                    child: Text(loadding.value ? 'Loadding'.tr : 'Sigin'.tr),
                    onPressed: loadding.value ? null : sigin,
                  )),
              SizedBox(
                height: 16,
              ),
              OutlinedButton(
                child: Text('Sign up for free!'.tr),
                onPressed: sigup,
              ),
            ],
          )),
    );
  }

  Future<void> sigin() async {
    if (!formKey.currentState!.validate()) return;
    final username = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    loadding.value = true;
    var service = Get.find<UserManagerService>();
    try {
      var result = await service.signIn(username, password);
      if (result.isValue && result.asValue?.value == true)
        Get.back(result: true);
      else
        showSnack(result.asError!.error.toString().tr);
    } catch (ex, st) {
      errorSnack(ex.toString().tr, st);
    }
    loadding.value = false;
  }

  void sigup() {
    Get.toNamed('/login/signup');
  }
}
