import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/snackbar.utils.dart';
import '../../../data/models/register.model.dart';
import '../../../data/providers/network/authentication_provider.dart';

class RegisterController extends GetxController {
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordVerifiy = new TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  AuthenticationProvider authApi = Get.put(AuthenticationProvider());
  RxBool loadingSave = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register() async {
    try {
      if (this.passwordVerifiy.text != this.password.text) {
        snackbar.show(message: 'Konfirmasi password tidak cocok');
        return;
      }

      this.loadingSave.value = true;
      String userNumber = this.generateRandomText();

      RegisterModel body = RegisterModel(
          address: this.address.value.text,
          name: this.name.value.text,
          userNumber: userNumber,
          email: this.email.value.text,
          phone: this.phone.value.text,
          password: this.password.value.text);

      await this.authApi.register(body);
      Get.back();
      snackbar.show(message: "Daftar akun berhasil");
    } catch (e) {
      snackbar.show(message: e.toString());
    } finally {
      this.loadingSave.value = false;
    }
  }

  String generateRandomText() {
    int rand = Random().nextInt(100000);
    return rand.toString();
  }
}
