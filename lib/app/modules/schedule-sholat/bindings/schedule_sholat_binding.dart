import 'package:get/get.dart';

import '../controllers/schedule_sholat_controller.dart';

class ScheduleSholatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleSholatController>(
      () => ScheduleSholatController(),
    );
  }
}
