import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

final List<String> imgList = [
  'lib/assets/images/banner1.jpg',
  'lib/assets/images/banner2.jpg',
  'lib/assets/images/banner3.png',
];

class HomeView extends GetView<HomeController> {
  final ctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Container(
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                        Icon(Icons.location_on),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bintaro, Tangerang Selatan',
                            ),
                            Text(
                              'Sholat Ashar : 15.00 WIB',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )
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
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 235, 235),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: CarouselSlider(
                    carouselController: ctrl.carouselController,
                    options: CarouselOptions(
                        aspectRatio: 2.0,
                        autoPlay: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          ctrl.current.value = index;
                        },
                        enlargeStrategy: CenterPageEnlargeStrategy.height),
                    items: imgList
                        .map(
                          (item) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover)),
                          ),
                        )
                        .toList(),
                  )),
              Obx(
                () => Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            ctrl.carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      ctrl.current == entry.key ? 0.9 : 0.4)),
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
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
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
                                  Get.toNamed(Routes.PROFILE);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: appThemeData.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
                                      Get.toNamed(Routes.PROFILE);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: appThemeData.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
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
                                  Get.toNamed(Routes.PROFILE);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: appThemeData.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
                              ))
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
                                      Get.toNamed(Routes.PROFILE);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: appThemeData.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
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
                                      Get.toNamed(Routes.PROFILE);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: appThemeData.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
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
                              ),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.PROFILE);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: appThemeData.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
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
                      )))
            ],
          ),
        ),
      ],
    )));
  }
}
