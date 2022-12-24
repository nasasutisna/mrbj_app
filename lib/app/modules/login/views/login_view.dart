import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/mrbj-button.dart';
import '../../../widgets/mrbj-textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final ctrl = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Icon(
                        Icons.mosque_outlined,
                        color: appThemeData.primaryColor,
                        size: 80,
                      )),
                ),
              ),
              MrbjTextField(
                  controller: ctrl.email,
                  labelText: 'Email',
                  required: true,
                  alignLabelWithHint: true,
                  hintText: 'Masukkan email'),
              MrbjTextField(
                  controller: ctrl.password,
                  labelText: 'Password',
                  required: true,
                  alignLabelWithHint: true,
                  obscureText: true,
                  hintText: 'Masukkan password'),
              SizedBox(
                height: 20,
              ),
              Obx(() => MrbjButton(
                    label: 'Masuk',
                    loading: controller.loading.value,
                    onPressed: () {
                      if (controller.loading.value == false) {
                        ctrl.doLogin();
                      }
                    },
                  )),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text('Pengguna Baru?'),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.REGISTER),
                    child: Text(
                      'Buat Akun',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
