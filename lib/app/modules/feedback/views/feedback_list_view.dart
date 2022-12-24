import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mrbj_app/app/data/models/feedback.model.dart';
import 'package:mrbj_app/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';

import '../../../core/theme/colors_theme.dart';

class FeedbackListView extends GetView<FeedbackController> {
  const FeedbackListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feedback List'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(Routes.FEEDBACK);
              },
            )
          ],
        ),
        body: PagedListView(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<DataFeedback>(itemBuilder: ((context, item, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: borderColor))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.department,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.review,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              );
            }))));
  }
}
