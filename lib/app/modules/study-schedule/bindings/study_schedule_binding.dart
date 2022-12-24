import 'package:get/get.dart';

import '../controllers/study_schedule_controller.dart';

class StudyScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyScheduleController>(
      () => StudyScheduleController(),
    );
  }
}
