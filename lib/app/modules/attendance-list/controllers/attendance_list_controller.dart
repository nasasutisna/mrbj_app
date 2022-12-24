import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mrbj_app/app/data/models/attendances/user-attendance.model.dart';

import '../../../data/providers/network/attendances_provider.dart';

class AttendanceListController extends GetxController {
  AttendancesProvider attendancesProvider = Get.put(AttendancesProvider());

  final PagingController<int, UserAttendanceModel> pagingController = PagingController(firstPageKey: 1);
  static const _pageSize = 20;
  String selectedValue = "7days";
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("7 Hari Terakhir"), value: "7days"),
    DropdownMenuItem(child: Text("1 Bulan Terakhir"), value: "1month"),
    DropdownMenuItem(child: Text("3 Bulan Terakhir"), value: "3month"),
    DropdownMenuItem(child: Text("6 Bulan Terakhir"), value: "6month"),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getUsersAttendance(pageKey);
    });
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

  Future<void> getUsersAttendance(int pageKey) async {
    try {
      String startDate = DateTime.now().toIso8601String();
      String endDate = DateTime.now().add(Duration(hours: 23, minutes: 59)).toIso8601String();

      switch (selectedValue) {
        case '7days':
          startDate = DateTime.now().subtract(Duration(days: 7)).toIso8601String();
          break;
        case '1month':
          startDate = DateTime.now().subtract(Duration(days: 30)).toIso8601String();
          break;
        case '3month':
          startDate = DateTime.now().subtract(Duration(days: 90)).toIso8601String();
          break;
        case '6month':
          startDate = DateTime.now().subtract(Duration(days: 120)).toIso8601String();
          break;
        default:
      }

      startDate = startDate.substring(0, 10);
      endDate = endDate.substring(0, 10);

      List<UserAttendanceModel> newItems =
          await attendancesProvider.getUsersAttendance(limit: _pageSize, page: pageKey, startDate: startDate, endDate: endDate);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      print('error $e');
      pagingController.error = e;
    }
  }
}
