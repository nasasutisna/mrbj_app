import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mrbj_app/app/data/models/city.model.dart';
import 'package:mrbj_app/app/data/providers/services/storage.service.dart';

import '../../../data/models/schedule-sholat-per-day.model.dart';
import '../../../data/providers/network/schedules_sholat_provider.dart';
import 'dart:async';

class ScheduleSholatController extends GetxController {
  SchedulesSholatProvider schedulesSholatProvider = Get.put(SchedulesSholatProvider());
  final jadwalSholat = Rxn<Data>();
  final listCity = Rxn<List<CityModel>>();
  final listCityResultSearch = Rxn<List<CityModel>>();
  RxBool loading = true.obs;
  TextEditingController searchText = TextEditingController();
  final searchOnChange = Rxn<String>();
  Timer? _debounceTimer;
  RxBool isSearch = false.obs;
  String idKotaTangsel = '1108';

  @override
  void onInit() {
    this.searchText.addListener(this.onChangeSearch);
    super.onInit();
  }

  @override
  void onReady() {
    this.getSchedulePerDaySholat();
    this.getCity();
    super.onReady();
  }

  @override
  void onClose() {
    this.searchText.removeListener(this.onChangeSearch);
    super.onClose();
  }

  onChangeSearch() {
    debouncing(
        fn: () {
          String keyword = this.searchText.value.text;
          if (keyword == '') {
            print('notsearch');
            this.isSearch.value = false;
          } else {
            print('search');
            this.isSearch.value = true;
          }
          print('debounce ${this.searchText.value.text}');
          this.listCityResultSearch.value = this.listCity.value!.where((city) => city.lokasi!.toLowerCase().contains(keyword.toLowerCase())).toList();

          print(cityModelToJson(this.listCityResultSearch.value!));
        },
        waitForMs: 1000);
  }

  void debouncing({required Function() fn, int waitForMs = 500}) {
    // if this function is called before 500ms [waitForMs] expired
    //cancel the previous call
    _debounceTimer?.cancel();
    // set a 500ms [waitForMs] timer for the [fn] to be called
    _debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

  getSchedulePerDaySholat({String? id}) async {
    try {
      this.loading.value = true;
      var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String idCity = this.idKotaTangsel;
      bool isSameDay = false;
      Data? data;

      try {
        final scheduleSholat = await storageService.getStorage<Map<String, dynamic>>('scheduleSholat');
        if (scheduleSholat != '') {
          data = Data.fromJson(scheduleSholat);
          jadwalSholat.value = data;
          var date = DateFormat('yyyy-MM-dd').format(data.jadwal.date);
          isSameDay = date == dateNow;
        }
      } catch (e) {
        print('error storage $e');
      }

      print('id $id');

      if (isSameDay == false && id != null) {
        idCity = id;
        ScheduleSholatPerDayModel result = await schedulesSholatProvider.getScheduleSholatPerDay(idCity: idCity);
        jadwalSholat.value = result.data;
        storageService.setStorage('scheduleSholat', jadwalSholat.value);
      }
    } catch (e) {
      print(e);
    } finally {
      this.loading.value = false;
    }
  }

  getCity() async {
    try {
      this.loading.value = true;
      List<CityModel> result = await schedulesSholatProvider.getCity();
      this.listCity.value = result;
    } catch (e) {
      print(e);
    } finally {
      this.loading.value = false;
    }
  }

  changeCity(String? id) {
    print('change city $id');
    storageService.setStorage('city-sholat', id);
    this.getSchedulePerDaySholat(id: id);
    this.schedulesSholatProvider.load.value = !this.schedulesSholatProvider.load.value;
  }
}
