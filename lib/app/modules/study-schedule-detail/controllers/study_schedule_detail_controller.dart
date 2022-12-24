import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mrbj_app/app/core/utils/dialog.util.dart';
import 'package:mrbj_app/app/core/utils/snackbar.utils.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';

import '../../../data/models/study-schedule.model.dart';
import '../../../data/providers/network/study_schedule_provider.dart';

class StudyScheduleDetailController extends GetxController {
  StudyScheduleProvider studyScheduleProvider = Get.put(StudyScheduleProvider());
  AuthenticationProvider authenticationProvider = Get.put(AuthenticationProvider());

  int? id;
  Rx<Datum> item = Datum(
          idStudySchedule: 0,
          title: '',
          description: '',
          time: DateTime.now(),
          location: '',
          image: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
      .obs;

  RxBool loading = true.obs;
  @override
  void onInit() {
    initializeDateFormatting();
    var params = Get.arguments;
    var id = params['id'] ?? null;
    this.getStudySchedule(id);
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

  Future<void> getStudySchedule(int id) async {
    try {
      this.loading.value = true;
      dynamic newItems = await studyScheduleProvider.getScheduleDetail(id);
      print(datumStudyScheduleToJson(newItems));
      this.item.value = newItems;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      this.loading.value = false;
    }
  }

  Future<void> remove() async {
    try {
      final confirm = await alert.confirm('Apakah yakin ingin menghapus data ini?');
      print('confirm $confirm');
      if (confirm == true) {
        loading.value = true;
        await studyScheduleProvider.remove(item.value.idStudySchedule!);
        studyScheduleProvider.reload.value = !studyScheduleProvider.reload.value;
        Get.back();
        snackbar.show(message: 'Data berhasil dihapus');
      }
    } catch (e) {
      snackbar.showError(error: e);
    } finally {
      loading.value = false;
    }
  }
}
