import 'dart:convert';

import 'package:get/get.dart';
import 'package:mrbj_app/app/data/models/attendances/user-attendance.model.dart';

class AttendanceListDetailController extends GetxController {
  //TODO: Implement AttendanceListDetailController
  Rxn<UserAttendanceModel> user = Rxn();
  final count = 0.obs;
  @override
  void onInit() {
    final params = Get.parameters;
    user.value = UserAttendanceModel.fromJson(jsonDecode(params['user'] as String));
    // userAttendanceModel = userAttendanceModelFromJson(params[]);
    print(' Get.params; ${user.value?.fullName}');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
