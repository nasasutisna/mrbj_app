import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mrbj_app/app/data/models/attendances/user-attendance.model.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';

import '../controllers/attendance_list_controller.dart';

class AttendanceListView extends GetView<AttendanceListController> {
  const AttendanceListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Kehadiran'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                      labelText: 'Filter',
                    ),
                    value: controller.selectedValue,
                    items: controller.menuItems,
                    hint: Text('Filter'),
                    onChanged: (value) {
                      controller.selectedValue = value.toString();
                      controller.pagingController.refresh();
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: PagedListView<int, UserAttendanceModel>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<UserAttendanceModel>(itemBuilder: (context, item, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.ATTENDANCE_LIST_DETAIL, parameters: {"user": jsonEncode(item)}),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            border: Border.all(width: 1, color: Color.fromARGB(255, 231, 231, 231)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.fullName,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SUBUH : ${item.subuh}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DZUHUR : ${item.dzuhur}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ASHAR : ${item.ashar}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MAGHRIB : ${item.maghrib}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ISYA : ${item.isya}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                }),
              ),
            ),
          ],
        )));
  }
}
