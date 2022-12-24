import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kritik & Saran'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: <Widget>[
                Form(
                    key: controller.form,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 16),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              padding: EdgeInsets.only(top: 20),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: .0, bottom: 5.0),
                                  labelText: 'Bagian',
                                ),
                                value: controller.selectedValue,
                                items: controller.menuItems,
                                hint: Text('Bagian'),
                                onChanged: (value) {
                                  print(value);
                                  controller.selectedValue = value.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15.0),
                          child: TextFormField(
                            maxLines: 4,
                            controller: controller.review,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Kritik dan saran',
                                alignLabelWithHint: true,
                                hintText: 'Masukkan kritik dan saran'),
                          ),
                        ),
                      ],
                    )),
                Container(
                  height: 40,
                  width: 250,
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(20)),
                  child: Obx(() => TextButton(
                        onPressed: () {
                          if (controller.loadingSave.value == false) {
                            controller.save();
                          }
                        },
                        child: controller.loadingSave.value == true
                            ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                'Kirim',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
