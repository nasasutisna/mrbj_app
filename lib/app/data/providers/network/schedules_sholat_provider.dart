import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mrbj_app/app/data/models/schedule-sholat-per-day.model.dart';
import 'package:mrbj_app/app/data/providers/services/notification.service.dart';

import '../../models/city.model.dart';

class SchedulesSholatProvider extends GetConnect {
  final baseUrl = 'https://api.myquran.com/v1';
  final idKotaTangsel = 1108;
  final load = false.obs;
  NotificationService notificationService = NotificationService();

  @override
  void onInit() {}

  createScheduleNotifSholat(Jadwal jadwal) async {
    var date = jadwal.date;
    var subuh = createDateTime(date, jadwal.subuh);
    var dzuhur = createDateTime(date, jadwal.dzuhur);
    var ashar = createDateTime(date, jadwal.ashar);
    var maghrib = createDateTime(date, jadwal.maghrib);
    var isya = createDateTime(date, jadwal.isya);
    var dateTimes = [subuh, dzuhur, ashar, maghrib, isya];
    var dateTimesLabel = ["Subuh", "Dzuhur", "Ashar", "Maghrib", "Isya"];
    var jadwalSholat = [jadwal.subuh, jadwal.dzuhur, jadwal.ashar, jadwal.maghrib, jadwal.isya];
    dateTimes.asMap().forEach((index, value) async {
      final now = DateTime.now();
      if (now.isBefore(value)) {
        await setScheduleNotification(value, dateTimesLabel[index], jadwalSholat[index]);
      }
    });

    await notificationService.cancelAll();
    await setScheduleNotification(subuh.add(Duration(days: 1)), 'Subuh', jadwal.subuh);
    await setScheduleNotification(dzuhur.add(Duration(days: 1)), 'Dzuhur', jadwal.dzuhur);
    await setScheduleNotification(ashar.add(Duration(days: 1)), 'Ashar', jadwal.ashar);
    await setScheduleNotification(maghrib.add(Duration(days: 1)), 'Maghrib', jadwal.maghrib);
    await setScheduleNotification(isya.add(Duration(days: 1)), 'Isya', jadwal.isya);
    List<ActiveNotification> notif = await notificationService.getAllSchedules();
    print('notif length ${notif.length}');
  }

  getCodeSholat(Jadwal jadwal) async {
    var date = jadwal.date;
    var subuh = createDateTime(date, jadwal.subuh);
    var dzuhur = createDateTime(date, jadwal.dzuhur);
    var ashar = createDateTime(date, jadwal.ashar);
    var maghrib = createDateTime(date, jadwal.maghrib);
    var isya = createDateTime(date, jadwal.isya);

    var dateTimes = [subuh, dzuhur, ashar, maghrib, isya];
    var codeSholat = ['MRBJ-SUBUH', 'MRBJ-DZUHUR', 'MRBJ-ASHAR', 'MRBJ-MAGHRIB', 'MRBJ-ISYA'];
    final now = DateTime.now();
    final closetsDateTimeToNow =
        dateTimes.reduce((a, b) => a.difference(now).abs() < b.difference(now).abs() ? a : b);
    var idx = dateTimes.indexWhere((element) => element == closetsDateTimeToNow);
    return codeSholat[idx];
  }

  DateTime createDateTime(DateTime dateTime, String hourTime) {
    final splitDate = dateTime.toIso8601String().substring(0, 10);
    DateTime dt = DateTime.parse('${splitDate} ${hourTime}');
    var tgl = dt.day;
    var month = dt.month;
    var year = dt.year;
    var hour = dt.hour;
    var minutes = dt.minute;
    return DateTime(year, month, tgl, hour, minutes);
  }

  Future<void> setScheduleNotification(DateTime date, String sholat, String hourSholat) {
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    return notificationService.showScheduledLocalNotification(
        id: randomNumber,
        title: "Waktu sholat $sholat sudah tiba!",
        body: "Waktu sholat $sholat pukul ${hourSholat} WIB",
        payload: "Waktu sholat $sholat sudah tiba!",
        dateTime: date);
  }

  Future<ScheduleSholatPerDayModel> getScheduleSholatPerDay(
      {String? dateNow, String? idCity}) async {
    try {
      final date = dateNow != null ? dateNow : DateFormat('y/M/d').format(DateTime.now());
      final id = idCity != null ? idCity : idKotaTangsel;
      final response = await get('/sholat/jadwal/${id}/${date}');
      final result = scheduleSholatPerDayModelFromJson(responseHandler(response));
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CityModel>> getCity() async {
    try {
      final response = await get('/sholat/kota/semua');
      final result = cityModelFromJson(responseHandler(response));
      return result;
    } catch (e) {
      throw e;
    }
  }

  responseHandler<T>(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response.bodyString;
      case 500:
        throw "Mohon maaf, Sepertinya servernya sedang bermasalah. Coba lagi nanti ya :)";
      case 400:
      case 422:
      case 401:
      case 403:
        throw response.body;
      default:
        throw 'Mohon maaf, Sepertinya ada sesuatu yang salah. Coba lagi nanti ya :)';
    }
  }
}
