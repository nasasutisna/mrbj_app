import 'package:get/get.dart';

import '../modules/attendance-list-detail/bindings/attendance_list_detail_binding.dart';
import '../modules/attendance-list-detail/views/attendance_list_detail_view.dart';
import '../modules/attendance-list/bindings/attendance_list_binding.dart';
import '../modules/attendance-list/views/attendance_list_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/coming-soon/bindings/coming_soon_binding.dart';
import '../modules/coming-soon/views/coming_soon_view.dart';
import '../modules/feedback/bindings/feedback_binding.dart';
import '../modules/feedback/views/feedback_list_view.dart';
import '../modules/feedback/views/feedback_view.dart';
import '../modules/forgot-password/bindings/forgot_password_binding.dart';
import '../modules/forgot-password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/schedule-sholat/bindings/schedule_sholat_binding.dart';
import '../modules/schedule-sholat/views/schedule_sholat_view.dart';
import '../modules/study-schedule-detail/bindings/study_schedule_detail_binding.dart';
import '../modules/study-schedule-detail/views/study_schedule_detail_view.dart';
import '../modules/study-schedule/bindings/study_schedule_binding.dart';
import '../modules/study-schedule/views/study_schedule_form_view.dart';
import '../modules/study-schedule/views/study_schedule_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
      name: _Paths.TABS,
      page: () => TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
        name: _Paths.ATTENDANCE,
        page: () => AttendanceView(),
        binding: AttendanceBinding()),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: _Paths.STUDY_SCHEDULE,
        page: () => const StudyScheduleView(),
        binding: StudyScheduleBinding()),
    GetPage(
        name: _Paths.STUDY_SCHEDULE_FORM,
        page: () => const StudyScheduleFormView(),
        binding: StudyScheduleBinding()),
    GetPage(
        name: _Paths.STUDY_SCHEDULE_DETAIL,
        page: () => const StudyScheduleDetailView(),
        binding: StudyScheduleDetailBinding()),
    GetPage(
        name: _Paths.SCHEDULE_SHOLAT,
        page: () => const ScheduleSholatView(),
        binding: ScheduleSholatBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
      name: _Paths.COMING_SOON,
      page: () => const ComingSoonView(),
      binding: ComingSoonBinding(),
    ),
    GetPage(
        name: _Paths.FEEDBACK,
        page: () => const FeedbackView(),
        binding: FeedbackBinding()),
    GetPage(
        name: _Paths.FEEDBACK_LIST,
        page: () => const FeedbackListView(),
        binding: FeedbackBinding()),
    GetPage(
      name: _Paths.ATTENDANCE_LIST,
      page: () => const AttendanceListView(),
      binding: AttendanceListBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_LIST_DETAIL,
      page: () => const AttendanceListDetailView(),
      binding: AttendanceListDetailBinding(),
    ),
  ];
}
