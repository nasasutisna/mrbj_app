import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrbj_app/app/data/providers/network/base_api_provider.dart';
import '../../models/study-schedule.model.dart';

class StudyScheduleProvider extends BaseApiProvider {
  final model = 'study-schedule';
  final reload = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<StudyScheduleModel> getSchedule({int? limit = 20, int? page = 1}) async {
    try {
      final response = await get('$model?limit=$limit&page=$page');
      final result = studyScheduleModelFromJson(responseHandler(response));
      result.data!.map((e) {
        e.image = '${httpClient.baseUrl}files/study/${e.image}';
        return e;
      }).toList();

      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<Datum> getScheduleDetail(int id) async {
    try {
      final response = await get('$model/detail/$id');
      final result = datumStudyScheduleFromJson(responseHandler(response));
      result.image = '${httpClient.baseUrl}files/study/${result.image}';

      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<void> store(XFile file, StoreStudyScheduleModel data) async {
    try {
      String filename = file.path.split('/').last;
      FormData formData = FormData({
        "file": await MultipartFile(file.path, filename: filename),
        "title": data.title,
        "description": data.description,
        "time": data.time,
        "location": data.location,
      });

      final response = await post('$model/store', formData);
      print('response ${response}');
      return responseHandler(response);
    } catch (e) {
      throw e;
    }
  }

  Future<void> remove(int id) async {
    try {
      final response = await post('$model/delete', {"id": id});
      return responseHandler(response);
    } catch (e) {
      throw e;
    }
  }
}
