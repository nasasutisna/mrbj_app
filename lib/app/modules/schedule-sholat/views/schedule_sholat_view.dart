import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/schedule_sholat_controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ScheduleSholatView extends GetView<ScheduleSholatController> {
  const ScheduleSholatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Sholat'),
          centerTitle: true,
        ),
        body: Obx(() => controller.loading.value == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () async => await modalBottomSheet(context),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.gps_fixed_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(controller
                                          .jadwalSholat.value!.lokasi),
                                    )
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Imsak',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller
                                        .jadwalSholat.value!.jadwal.imsak,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subuh',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                  controller
                                      .jadwalSholat.value!.jadwal.subuh,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Terbit',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller.jadwalSholat.value!.jadwal
                                        .terbit,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dhuha',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller
                                        .jadwalSholat.value!.jadwal.dhuha,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dzuhur',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller.jadwalSholat.value!.jadwal
                                        .dzuhur,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ashar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller
                                        .jadwalSholat.value!.jadwal.ashar,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Maghrib',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller.jadwalSholat.value!.jadwal
                                        .maghrib,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Isya',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                    controller
                                        .jadwalSholat.value!.jadwal.isya,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )));
  }

  Future<void> modalBottomSheet(context) async {
    return await showCupertinoModalBottomSheet(
      context: context,
      expand: false,
      backgroundColor: Colors.white,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 100,
                  margin: EdgeInsets.only(bottom: 16, top: 8),
                  padding: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
                TextFormField(
                  controller: controller.searchText,
                  decoration: InputDecoration(
                      hintText: 'Cari kota/kabupaten',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Obx(() => controller.isSearch.value == true
                      ? ListView.builder(
                          itemCount:
                              controller.listCityResultSearch.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  controller.changeCity(controller
                                      .listCityResultSearch.value![index].id);
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(controller
                                      .listCityResultSearch.value![index].lokasi
                                      .toString()),
                                ));
                          })
                      : ListView.builder(
                          itemCount: controller.listCity.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  controller.changeCity(
                                      controller.listCity.value![index].id);
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(controller
                                      .listCity.value![index].lokasi
                                      .toString()),
                                ));
                          })),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
