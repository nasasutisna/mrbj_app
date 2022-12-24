import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mrbj_app/app/widgets/mrbj-item-detail.dart';

import '../controllers/attendance_list_detail_controller.dart';

class AttendanceListDetailView extends GetView<AttendanceListDetailController> {
  const AttendanceListDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
        ),
        body: Obx(() => Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MRBJItemDetail(title: 'Nama Lengkap', text: controller.user.value!.fullName),
                    MRBJItemDetail(title: 'Email', text: controller.user.value!.userDetail.email),
                    MRBJItemDetail(title: 'Nomor HP', text: controller.user.value!.userDetail.phone),
                    MRBJItemDetail(title: 'Alamat', text: controller.user.value!.userDetail.address),
                  ],
                ),
              ),
            )));
  }
}
