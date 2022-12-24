import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:mrbj_app/app/data/models/study-schedule.model.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';
import 'package:skeletons/skeletons.dart';

import '../controllers/study_schedule_controller.dart';

class StudyScheduleView extends GetView<StudyScheduleController> {
  const StudyScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Kajian'),
          centerTitle: true,
          backgroundColor: appThemeData.primaryColor,
          actions: [
            controller.authenticationProvider.isLoggedIn.value == true &&
                    controller.authenticationProvider.userLogged.role == 1
                ? IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.STUDY_SCHEDULE_FORM);
                    },
                  )
                : Container()
          ],
        ),
        body: PagedListView<int, Datum>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Datum>(itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.STUDY_SCHEDULE_DETAIL,
                    arguments: {'id': item.idStudySchedule}),
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
                        Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: MediaQuery.of(context).size.width / 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: item.image!,
                                placeholder: (context, url) => SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      shape: BoxShape.rectangle,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200),
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title!,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.location!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      ),
                                      Text(
                                        '${DateFormat.yMMMMEEEEd(controller.locale).format(item.time!)}, Jam ${DateFormat.Hm(controller.locale).format(item.time!)} - Selesai',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                item.description!,
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
          }),
        ));
  }
}
