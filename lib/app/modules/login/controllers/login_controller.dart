import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mrbj_app/app/core/utils/snackbar.utils.dart';
import 'package:mrbj_app/app/modules/tabs/controllers/tabs_controller.dart';

import '../../../data/providers/network/authentication_provider.dart';
import '../../../data/providers/services/storage.service.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginController extends GetxController {
  TextEditingController email =
      new TextEditingController(text: 'nasa@mailinator.com');
  TextEditingController password = new TextEditingController(text: 'pass1234');
  AuthenticationProvider authApi = Get.put(AuthenticationProvider());
  StorageService storageService = new StorageService();
  TabsController tabsController = Get.find();

  final count = 0.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    print('init login');
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('account $account');
    });
    _googleSignIn.signInSilently();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void doLogin() async {
    try {
      this.loading.value = true;
      String email = this.email.text;
      String password = this.password.text;
      await this.authApi.login(email, password);
      snackbar.show(message: "Selamat Datang");
      this.tabsController.tabs.index = 0;
    } catch (e) {
      snackbar.showError(error: e);
    } finally {
      this.loading.value = false;
    }
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(
        'signin failed $error',
      );
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();
}
