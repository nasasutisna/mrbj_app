import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/utils/snackbar.utils.dart';
import 'package:mrbj_app/app/data/models/attendances/attendances.model.dart';
import 'package:mrbj_app/app/data/providers/network/attendances_provider.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';
import 'package:mrbj_app/app/data/providers/network/schedules_sholat_provider.dart';
import 'package:mrbj_app/app/data/providers/services/storage.service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../data/models/schedule-sholat-per-day.model.dart';
import '../../tabs/controllers/tabs_controller.dart';

class AttendanceController extends GetxController {
  String idKotaTangsel = '1108';
  RxInt userId = 0.obs;
  RxBool loading = false.obs;
  TabsController tabsController = Get.find();
  AuthenticationProvider authenticationProvider = Get.find();
  AttendancesProvider attendancesProvider = Get.put(AttendancesProvider());
  SchedulesSholatProvider schedulesSholatProvider = Get.put(SchedulesSholatProvider());
  dynamic user = null;
  Jadwal? jadwalSholat;
  RxBool isAdmin = false.obs;

  Barcode? result;
  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void onInit() {
    this.getUser();
    this.getSchedulePerDaySholat();
    this.listener();
    super.onInit();
  }

  @override
  void onReady() async {
    if (GetPlatform.isDesktop == false) {
      await Future.delayed(Duration(seconds: 1));
      qrViewController?.resumeCamera();
    }

    super.onReady();
  }

  @override
  void onClose() {
    tabsController.tabs.removeListener(() {});
    authenticationProvider.isLoggedIn.close();
    qrViewController?.dispose();
  }

  listener() {
    tabsController.tabs.addListener(() {
      if (isAdmin == true) {
        if (tabsController.tabs.index == 1) {
          qrViewController?.resumeCamera();
        } else {
          qrViewController?.pauseCamera();
        }
      }
    });

    authenticationProvider.isLoggedIn.listen((value) {
      if (value == true) {
        this.getUser();
        this.getSchedulePerDaySholat();
      }
    });

    Timer.periodic(new Duration(minutes: 30), (timer) {
      this.getSchedulePerDaySholat();
    });
  }

  getSchedulePerDaySholat() async {
    try {
      String id = storageService.getStorage('city-sholat') ?? this.idKotaTangsel;
      ScheduleSholatPerDayModel result = await schedulesSholatProvider.getScheduleSholatPerDay(idCity: id);
      jadwalSholat = result.data!.jadwal;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async {
    try {
      user = storageService.getStorage('user');
      userId.value = user['userId'];
      isAdmin.value = user['role'] == 1 ? true : false;
    } catch (e) {
      print('error get userId $e');
    }
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    qrViewController?.scannedDataStream.listen((scanData) {
      result = scanData;
      if (result?.code != '') {
        saveAttendance(result?.code);
      }
    });
  }

  saveAttendance(String? userId) async {
    try {
      if (userId != '') {
        loading.value = true;
        var codeSholat = await schedulesSholatProvider.getCodeSholat(jadwalSholat!);
        AttendanceModel body = new AttendanceModel(time: DateTime.now(), codeSholat: codeSholat, userId: int.parse(userId!));
        await attendancesProvider.recordTime(body);
        snackbar.show(message: 'Berhasil disimpan, Terima Kasih', duration: 1);
      }
    } catch (e) {
      snackbar.showError(error: e);
    } finally {
      await Future.delayed(Duration(seconds: 2));
      loading.value = false;
      await Future.delayed(Duration(seconds: 2));
      qrViewController?.resumeCamera();
    }
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
