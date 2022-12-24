import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/mrbj-button.dart';
import '../../../widgets/mrbj-textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daftar'),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                children: <Widget>[
                  Form(
                      key: controller.form,
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Column(
                          children: [
                            MrbjTextField(
                                controller: controller.name,
                                labelText: 'Nama Lengkap',
                                required: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan nama lengkap'),
                            MrbjTextField(
                                controller: controller.email,
                                labelText: 'Email',
                                required: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan email'),
                            MrbjTextField(
                                controller: controller.phone,
                                labelText: 'Nomor HP',
                                required: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan nomor hp'),
                            MrbjTextField(
                                controller: controller.address,
                                labelText: 'Alamat',
                                required: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan alamat sekarang'),
                            MrbjTextField(
                                controller: controller.password,
                                labelText: 'Password',
                                required: true,
                                obscureText: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan password'),
                            MrbjTextField(
                                controller: controller.passwordVerifiy,
                                labelText: 'Konfirmasi Password',
                                required: true,
                                alignLabelWithHint: true,
                                hintText: 'Masukkan konfirmasi password'),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => MrbjButton(
                        label: 'Daftar',
                        loading: controller.loadingSave.value,
                        onPressed: () {
                          if (controller.loadingSave.value == false &&
                              controller.form.currentState!.validate() == true) {
                            controller.register();
                          }
                        },
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
