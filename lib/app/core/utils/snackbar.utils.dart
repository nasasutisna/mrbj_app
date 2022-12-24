import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar {
  void show({String? message, int duration = 3}) {
    Get.snackbar("Informasi", message ?? '',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.only(top: 12, left: 12, right: 12));
  }

  void showError({Object? error, int duration = 3}) {
    var messageError = error as dynamic;
    Get.snackbar("Informasi", messageError['message'] ?? '',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration),
        margin: EdgeInsets.only(top: 12, left: 12, right: 12));
  }
}

final snackbar = new Snackbar();
