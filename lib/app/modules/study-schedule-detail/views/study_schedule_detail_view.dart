import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

import '../controllers/study_schedule_detail_controller.dart';

class StudyScheduleDetailView extends GetView<StudyScheduleDetailController> {
  const StudyScheduleDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
           actions: [
            controller.authenticationProvider.isLoggedIn.value == true &&
                    controller.authenticationProvider.userLogged.role == 1
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.remove();
                    },
                  )
                : Container()
          ],
        ),
        body: Obx(
          () => controller.loading.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(6.0),
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
                          ), //BoxS)hadow
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 250,
                            width: MediaQuery.of(context).size.width / 1,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: controller.item.value.image!,
                              placeholder: (context, url) => SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    shape: BoxShape.rectangle,
                                    width: MediaQuery.of(context).size.width,
                                    height: 250),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12, bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.item.value.title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.item.value.location!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                        ),
                                        Text(
                                          '${DateFormat.yMMMMEEEEd(Get.locale.toString()).format(controller.item.value.time!)}, Jam ${DateFormat.Hm(Get.locale.toString()).format(controller.item.value.time!)} - Selesai',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  controller.item.value.description!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
        ));
  }
}
