import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mrbj_app/app/data/models/schedule-sholat-per-day.model.dart';
import 'package:mrbj_app/app/data/models/study-schedule.model.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';
import 'package:mrbj_app/app/data/providers/network/schedules_sholat_provider.dart';
import 'package:mrbj_app/app/data/providers/network/study_schedule_provider.dart';
import 'package:mrbj_app/app/data/providers/services/notification.service.dart';
import 'package:mrbj_app/app/data/providers/services/storage.service.dart';
import '../../../data/models/authentication.model.dart';
import '../../../routes/app_pages.dart';

class Sholat {
  late String subuh;
  late String dzuhur;
  late String ashar;
  late String maghrib;
  late String isya;

  Sholat({required this.subuh, required this.dzuhur, required this.ashar, required this.maghrib, required this.isya});
}

class HomeController extends GetxController {
  final current = 0.obs;
  final listStudySchedule = Rxn<StudyScheduleModel>();

  RxList<dynamic> jadwalSholat = [].obs;
  SchedulesSholatProvider schedulesSholatProvider = Get.put(SchedulesSholatProvider());
  StudyScheduleProvider studyScheduleProvider = Get.put(StudyScheduleProvider());
  AuthenticationProvider authProvider = Get.put(AuthenticationProvider());
  NotificationService notificationService = NotificationService();
  CarouselController carouselController = CarouselController();
  String idKotaTangsel = '1108';
  RxString city = ''.obs;
  RxBool loadingGetSchedule = true.obs;
  RxBool isAdmin = false.obs;

  @override
  void onInit() async {
    notificationService = NotificationService();
    await notificationService.initializePlatformNotifications();
    initializeDateFormatting('id', null).then((value) => null);
    eventsListener();
    super.onInit();
  }

  @override
  void onReady() {
    this.getSchedulePerDaySholat();
    this.getStudySchedule();
    this.checkRole();
    super.onReady();
  }

  @override
  void onClose() {
    this.schedulesSholatProvider.load.close();
  }

  eventsListener() {
    authProvider.isLoggedIn.listen((value) {
      if (value == true) {
        this.checkRole();
      }
    });

    this.schedulesSholatProvider.load.listen((_) {
      this.getSchedulePerDaySholat();
    });
  }

  checkRole() {
    var response = storageService.getStorage('user');
    if (response != null) {
      User user = User.fromJson(response);
      if (user.role == 1) {
        isAdmin.value = true;
      }
    }
  }

  getSchedulePerDaySholat() async {
    try {
      var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      bool isSameDay = false;
      Jadwal? jadwal;
      Data? data;

      try {
        final scheduleSholat = await storageService.getStorage<Map<String, dynamic>>('scheduleSholat');
        if (scheduleSholat != '') {
          data = Data.fromJson(scheduleSholat);
          jadwal = data.jadwal;
          city.value = data.lokasi;
          var date = DateFormat('yyyy-MM-dd').format(data.jadwal.date);
          isSameDay = date == dateNow;
        }
      } catch (e) {
        print('error storage $e');
      }

      if (isSameDay == false) {
        String id = storageService.getStorage('city-sholat') ?? this.idKotaTangsel;
        ScheduleSholatPerDayModel result = await schedulesSholatProvider.getScheduleSholatPerDay(idCity: id);
        data = result.data;
        jadwal = data!.jadwal;
        this.city.value = data.lokasi;
        storageService.setStorage('scheduleSholat', data);
      }

      this.jadwalSholat.value = [
        'Subuh ${jadwal?.subuh}',
        'Dzuhur ${jadwal?.dzuhur}',
        'Ashar ${jadwal?.ashar}',
        'Maghrib ${jadwal?.maghrib}',
        'Isya ${jadwal?.isya}'
      ];

      schedulesSholatProvider.createScheduleNotifSholat(jadwal!);
    } catch (e) {
      print(e);
    }
  }

  getStudySchedule() async {
    try {
      final tempStudySchedule = storageService.getStorage('studySchedule');
      try {
        if (tempStudySchedule != null) {
          StudyScheduleModel studySchedule = StudyScheduleModel.fromJson(tempStudySchedule);
          this.listStudySchedule.value = studySchedule;
        } else {
          this.loadingGetSchedule.value = true;
        }
      } catch (e) {
        print('error tempStudySchedule $e');
      }

      StudyScheduleModel result = await studyScheduleProvider.getSchedule();
      this.listStudySchedule.value = result;
      var temp = this.listStudySchedule.value!.data!.skip(0).take(3).toList();
      this.listStudySchedule.value!.data!.assignAll(temp);
      storageService.setStorage('studySchedule', result);
    } catch (e) {
      print('error getStudySchedule $e');
    } finally {
      this.loadingGetSchedule.value = false;
    }
  }

  Future<void> showLocalNotifition() {
    var dateNow = DateTime.now().add(Duration(seconds: 5));
    var sholat = 'Subuh';

    Random random = new Random();
    int randomNumber = random.nextInt(100);
    return notificationService.showScheduledLocalNotification(
        id: randomNumber,
        title: "Waktu sholat $sholat sudah tiba!",
        body: "Waktunya untuk bersiap-sap mengambil air wudhu untuk sholat $sholat",
        payload: "Waktu sholat $sholat sudah tiba!",
        dateTime: dateNow);
  }

  openPageFeedback() {
    try {
      if (authProvider.userLogged.role == 1) {
        Get.toNamed(Routes.FEEDBACK_LIST);
      } else {
        Get.toNamed(Routes.FEEDBACK);
      }
    } catch (e) {
      print('error $e');
      Get.toNamed(Routes.FEEDBACK);
    }
  }
}
