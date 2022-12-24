import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mrbj_app/app/data/models/feedback.model.dart';
import 'package:mrbj_app/app/data/providers/network/feedback_provider.dart';

import '../../../core/utils/snackbar.utils.dart';

class FeedbackController extends GetxController {
  TextEditingController review = new TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  FeedbackProvider feedbackProvider = Get.put(FeedbackProvider());
  RxBool loadingSave = false.obs;
  String selectedValue = "";

  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Pilih salah satu"), value: ""),
    DropdownMenuItem(child: Text("Umum"), value: "umum"),
    DropdownMenuItem(child: Text("Kajian"), value: "kajian"),
    DropdownMenuItem(child: Text("Fasilitas"), value: "fasilitas"),
  ];

  static const _pageSize = 20;
  final PagingController<int, DataFeedback> pagingController = PagingController(firstPageKey: 1);

  @override
  void onInit() {
    print('testing');
    pagingController.addPageRequestListener((pageKey) {
      getListData(pageKey);
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

  Future<void> getListData(int pageKey) async {
    try {
      FeedbackListModel newItems = await feedbackProvider.getFeedbackList(limit: _pageSize, page: pageKey);

      final isLastPage = newItems.data.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems.data);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems.data, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  save() async {
    try {
      if (selectedValue == '') {
        snackbar.show(message: "Pilih bagian departemen", duration: 3);
        return;
      }

      if (review.text == '') {
        snackbar.show(message: "Masukan kritik dan sarannya", duration: 3);
        return;
      }

      this.loadingSave.value = true;
      FeedbackModel body = FeedbackModel(department: selectedValue, review: review.text);
      await feedbackProvider.store(body);
      snackbar.show(message: "Kritik & Saran berhasil dikirim", duration: 3);
    } catch (e) {
      snackbar.showError(error: e);
    } finally {
      this.loadingSave.value = false;
    }
  }
}
