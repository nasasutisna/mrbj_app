import 'package:get/get.dart';

import '../controllers/coming_soon_controller.dart';

class ComingSoonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComingSoonController>(
      () => ComingSoonController(),
    );
  }
}
