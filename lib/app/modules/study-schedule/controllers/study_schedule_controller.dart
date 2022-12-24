import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mrbj_app/app/core/utils/snackbar.utils.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';

import '../../../core/utils/date.util.dart';
import '../../../data/models/study-schedule.model.dart';
import '../../../data/providers/network/study_schedule_provider.dart';

class StudyScheduleController extends GetxController {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final PagingController<int, Datum> pagingController = PagingController(firstPageKey: 1);
  final ImagePicker _picker = ImagePicker();
  static const _pageSize = 20;
  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  String? _retrieveDataError;
  RxBool loadingSave = false.obs;
  String selectedValue = "";
  DateTime selectedDate = DateTime.now();
  String locale = Get.locale.toString();
  StudyScheduleProvider studyScheduleProvider = Get.put(StudyScheduleProvider());
  AuthenticationProvider authenticationProvider = Get.put(AuthenticationProvider());
  RxList<Datum> listData = <Datum>[].obs;
  TextEditingController title = new TextEditingController();
  TextEditingController location = new TextEditingController(text: 'Masjid Raya Bintaro Jaya');
  TextEditingController desc = new TextEditingController();
  TextEditingController date = new TextEditingController(
      text: DateFormat.yMMMMEEEEd(Get.locale.toString()).format(DateTime.now()));
  TextEditingController time = new TextEditingController(text: '00:00');
  Rxn<XFile> selectedImage = Rxn();

  @override
  void onInit() {
    initializeDateFormatting();
    eventsListener();
    pagingController.addPageRequestListener((pageKey) {
      getStudySchedule(pageKey);
    });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pagingController.dispose();
    title.dispose();
    desc.dispose();
    time.dispose();
    location.dispose();
    selectedImage.close();
    super.onClose();
  }

  eventsListener() {
    studyScheduleProvider.reload.listen((value) {
      print('value $value');
      pagingController.refresh();
    });
  }

  takeImage(ImageSource source, double? maxWidth, double? maxHeight, int? quality) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );

      selectedImage.value = pickedFile;
      _setImageFileListFromFile(pickedFile);
    } catch (e) {
      _pickImageError = e;
    }
  }

  void _setImageFileListFromFile(XFile? value) {
    print('takeImage ${value?.path}');
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> getStudySchedule(int pageKey) async {
    try {
      print('getStudySchedule');
      StudyScheduleModel newItems =
          await studyScheduleProvider.getSchedule(limit: _pageSize, page: pageKey);
      final isLastPage = newItems.data!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems.data!);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems.data!, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  save() async {
    try {
      loadingSave.value = true;
      StoreStudyScheduleModel storeStudyScheduleModel = StoreStudyScheduleModel(
          title: this.title.text,
          description: this.desc.text,
          location: this.location.text,
          time: this.selectedDate.toIso8601String());

      await studyScheduleProvider.store(selectedImage.value!, storeStudyScheduleModel);
      pagingController.refresh();
      Get.back();
      snackbar.show(message: 'Data berhasil disimpan');
      resetForm();
    } catch (e) {
      snackbar.showError(error: e);
    } finally {
      loadingSave.value = false;
    }
  }

  resetForm() {
    title.text = '';
    desc.text = '';
    time.text = '00:00';
    selectedDate = DateTime.now();
    selectedImage.value = null;
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      date.text = DateFormat.yMMMMEEEEd(Get.locale.toString()).format(newSelectedDate);
      selectedDate = mergeDateTime(selectedDate, this.time.text);
    }
  }

  selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      var df = DateFormat("h:mm");
      var dt = df.parse(pickedTime.format(context));
      var finaltime = DateFormat('HH:mm').format(dt);
      time.text = finaltime;
      selectedDate = mergeDateTime(selectedDate, time.text);
    }
  }
}
