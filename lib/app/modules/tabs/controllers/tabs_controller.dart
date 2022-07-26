import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TabsController extends GetxController {
  //TODO: Implement TabsController

  final count = 0.obs;
  final PersistentTabController tabs = PersistentTabController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
