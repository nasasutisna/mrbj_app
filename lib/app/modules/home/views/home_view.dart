import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';
import 'package:skeletons/skeletons.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height - 50)),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    color: appThemeData.primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Assalam Mualaikum',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Icon(Icons.location_on),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(controller.city.value)),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Obx(() => CarouselSlider.builder(
                                    itemCount: controller.jadwalSholat.length,
                                    options: CarouselOptions(
                                        autoPlay: true, height: 28, scrollDirection: Axis.vertical, autoPlayInterval: Duration(seconds: 6)),
                                    itemBuilder: (context, index, realIdx) {
                                      return Container(
                                        child: Text(
                                          controller.jadwalSholat.length > 1 ? controller.jadwalSholat[index] : '-',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 16, top: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(color: Color.fromARGB(255, 235, 235, 235), borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Obx(() => CarouselSlider(
                        carouselController: ctrl.carouselController,
                        options: CarouselOptions(
                            aspectRatio: 2.0,
                            autoPlay: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              ctrl.current.value = index;
                            },
                            enlargeStrategy: CenterPageEnlargeStrategy.height),
                        items: controller.loadingGetSchedule.value == true || controller.listStudySchedule.value == null
                            ? []
                            : controller.listStudySchedule.value!.data!
                                .map(
                                  (item) => Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.STUDY_SCHEDULE_DETAIL, arguments: {"id": item.idStudySchedule});
                                          },
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context).size.width,
                                            imageUrl: item.image!,
                                            placeholder: (context, url) => SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  shape: BoxShape.rectangle, width: MediaQuery.of(context).size.width, height: 200),
                                            ),
                                          )),
                                    ),
                                  ),
                                )
                                .toList(),
                      ))),
              Obx(
                () => Container(
                  margin: EdgeInsets.only(left: 12),
                  child: controller.loadingGetSchedule.value == true || controller.listStudySchedule.value == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: controller.listStudySchedule.value!.data!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => ctrl.carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                        .withOpacity(ctrl.current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ),
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 16, top: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.SCHEDULE_SHOLAT);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                      child: Icon(
                                        Icons.schedule_rounded,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('Jadwal Sholat')
                                  ],
                                ),
                              )),
                              Container(
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.STUDY_SCHEDULE);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('Jadwal Kajian')
                                      ],
                                    )),
                              ),
                              Container(
                                child: InkWell(
                                    onTap: () {
                                      controller.openPageFeedback();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                          child: Icon(
                                            Icons.feedback,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('Kritik & Saran')
                                      ],
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.COMING_SOON);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                          child: Icon(
                                            Icons.money,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('Zakat & Wakaf')
                                      ],
                                    )),
                              ),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.COMING_SOON);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                      child: Icon(
                                        Icons.people_alt_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('Muamalah')
                                  ],
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.COMING_SOON);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(50)),
                                      child: Icon(
                                        Icons.discount,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('Pasar Amal')
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ],
                      ))),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
