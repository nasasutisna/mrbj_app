import 'package:get/get.dart';

import '../controllers/attendance_list_controller.dart';

class AttendanceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceListController>(
      () => AttendanceListController(),
    );
  }
}
