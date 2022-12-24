import 'package:get/get.dart';

import '../controllers/study_schedule_detail_controller.dart';

class StudyScheduleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyScheduleDetailController>(
      () => StudyScheduleDetailController(),
    );
  }
}
