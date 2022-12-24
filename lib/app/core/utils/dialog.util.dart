import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  Future<bool> confirm(String desc) async {
    bool response = false;
    await Get.defaultDialog(
        title: 'Konfirmasi',
        textConfirm: 'Yes',
        confirmTextColor: Colors.white,
        onConfirm: () {
          response = true;
          Get.back();
        },
        onCancel: () {
          response = false;
        },
        middleText: desc);

    return response;
  }
}

final alert = new Alert();
