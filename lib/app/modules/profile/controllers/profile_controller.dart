import 'package:get/get.dart';
import 'package:mrbj_app/app/data/models/authentication.model.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';
import 'package:mrbj_app/app/data/providers/services/storage.service.dart';

import '../../tabs/controllers/tabs_controller.dart';

class ProfileController extends GetxController {
  AuthenticationProvider authProvider = Get.put(AuthenticationProvider());
  TabsController tabsController = Get.find();
  final count = 0.obs;
  User? userInfo = null;
  RxBool isLoggin = false.obs;

  @override
  void onInit() {
    String now = new DateTime.now().toIso8601String();
    print('date ${now}');
    super.onInit();
  }

  @override
  void onReady() {
    this.getUser();
    super.onReady();
  }

  @override
  void onClose() {}

  getUser() {
    final user = storageService.getStorage<dynamic>('user');
    if (user != null) {
      this.userInfo = User.fromJson(user);
      isLoggin.value = true;
    }
  }

  logout() {
    storageService.clearStorage();
    tabsController.tabs.index = 0;
    authProvider.isLoggedIn.value = false;
  }
}
