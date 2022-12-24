import 'package:get/get.dart';
import 'package:mrbj_app/app/data/models/authentication.model.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/utils/snackbar.utils.dart';
import '../../../data/providers/services/storage.service.dart';

class TabsController extends GetxController {
  final count = 0.obs;
  final isLoggin = false.obs;
  User? userInfo = null;

  final PersistentTabController tabs = PersistentTabController(initialIndex: 0);
  AuthenticationProvider authProvider = Get.put(AuthenticationProvider());

  @override
  void onInit() {
    authProvider.isLoggedIn.listen((value) {
      isLoggin.value = value;
      if (value == true) {
        final user = storageService.getStorage('user');
        this.userInfo = User.fromJson(user);
      }
    });

    tabs.addListener(() {
      if (authProvider.isLoggedIn.value == false && tabs.index == 1) {
        snackbar.show(message: "Maaf anda belum login :)");
        tabs.index = 2;
      }
    });

    super.onInit();
  }

  @override
  void onReady() async {
    this.checkAuth();
    super.onReady();
  }

  @override
  void onClose() {}

  void checkAuth() async {
    await Future.delayed(Duration(milliseconds: 200));
    final user = storageService.getStorage('user');
    if (user != null) {
      this.userInfo = User.fromJson(user);
      authProvider.isLoggedIn.value = true;
    }
  }
}
