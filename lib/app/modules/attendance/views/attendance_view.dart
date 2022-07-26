import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(() {
                return Text('Barcode result: ${controller.barcodeResult}');
              }),
              ElevatedButton(
                  onPressed: () => controller.scanQR(),
                  child: Text('Scan')),
            ]));
  }
}
