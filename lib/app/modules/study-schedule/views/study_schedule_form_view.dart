import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrbj_app/app/modules/study-schedule/controllers/study_schedule_controller.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/mrbj-button.dart';
import '../../../widgets/mrbj-textfield.dart';

class StudyScheduleFormView extends GetView<StudyScheduleController> {
  const StudyScheduleFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Jadwal Kajian'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: <Widget>[
                  Form(
                    key: controller.form,
                    child: Column(
                      children: [
                        MrbjTextField(
                            controller: controller.title,
                            labelText: 'Judul',
                            required: true,
                            alignLabelWithHint: true,
                            hintText: 'Masukkan judul'),
                        MrbjTextField(
                            controller: controller.desc,
                            labelText: 'Deskripsi',
                            required: true,
                            alignLabelWithHint: true,
                            hintText: 'Masukkan deskripsi'),
                        MrbjTextField(
                            controller: controller.location,
                            labelText: 'Lokasi',
                            required: true,
                            alignLabelWithHint: true,
                            hintText: 'Masukkan lokasi'),
                        MrbjTextField(
                            controller: controller.date,
                            labelText: 'Tanggal Acara',
                            required: true,
                            readOnly: true,
                            alignLabelWithHint: true,
                            onTap: () => controller.selectDate(context),
                            hintText: 'Pilih tanggal'),
                        MrbjTextField(
                            controller: controller.time,
                            labelText: 'Jam',
                            required: true,
                            alignLabelWithHint: true,
                            readOnly: false,
                            onTap: () => controller.selectTime(context),
                            hintText: 'Pilih jam'),
                        Obx(() => controller.selectedImage.value != null
                            ? Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Image.file(File(controller.selectedImage.value!.path))
                                  ],
                                ),
                              )
                            : Container()),
                        Container(
                          height: 50,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(16),
                          child: OutlinedButton.icon(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16))),
                            onPressed: () =>
                                controller.takeImage(ImageSource.gallery, 300, 250, 100),
                            icon: Icon(
                              Icons.camera_alt,
                              size: 24.0,
                            ),
                            label: Text(
                              'Unggah Gambar',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => MrbjButton(
                        label: 'Simpan',
                        loading: controller.loadingSave.value,
                        onPressed: () {
                          if (controller.loadingSave.value == false &&
                              controller.form.currentState!.validate() == true) {
                            controller.save();
                          }
                        },
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
