import 'package:get/get.dart';

import '../controllers/attendance_list_detail_controller.dart';

class AttendanceListDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceListDetailController>(
      () => AttendanceListDetailController(),
    );
  }
}
