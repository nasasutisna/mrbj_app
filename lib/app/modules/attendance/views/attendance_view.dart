import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return Obx(() => controller.loading.value == true
        ? Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text("Sedang menyimpan..."),
                  )
                ],
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Flex(direction: Axis.vertical, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              controller.isAdmin.value == true
                  ? Expanded(flex: 4, child: _buildQrView(context))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: QrImage(
                            data: controller.userId.value.toString(),
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.userId.value.toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
            ])));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: controller.onQRViewCreated,
      cameraFacing: CameraFacing.front,
      overlay: QrScannerOverlayShape(borderColor: Colors.white, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => controller.onPermissionSet(context, ctrl, p),
    );
  }
}
