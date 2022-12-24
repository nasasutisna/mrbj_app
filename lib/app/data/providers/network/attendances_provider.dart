import 'package:mrbj_app/app/data/models/attendances/attendances.model.dart';

import '../../models/attendances/user-attendance.model.dart';
import 'base_api_provider.dart';

class AttendancesProvider extends BaseApiProvider {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> recordTime(AttendanceModel data) async {
    try {
      final body = attendanceModelToJson(data);
      final response = await post('attendances/recordTime', body);
      return responseHandler(response);
    } catch (e) {
      throw e;
    }
  }

  Future<List<UserAttendanceModel>> getUsersAttendance({int? limit = 20, int? page = 1, String? startDate = null, String? endDate = null}) async {
    try {
      if (startDate == null) {
        startDate = DateTime.now().subtract(Duration(days: 7)).toIso8601String();
      }

      if (endDate == null) {
        endDate = DateTime.now().toIso8601String();
      }

      final response = await get('users/getUsersAttendance?limit=$limit&page=$page&startDate=$startDate&endDate=$endDate');
      final result = userAttendanceModelFromJson(responseHandler(response));
      return result;
    } catch (e) {
      throw e;
    }
  }
}
