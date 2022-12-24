import 'package:mrbj_app/app/data/models/feedback.model.dart';
import 'package:mrbj_app/app/data/providers/network/base_api_provider.dart';

class FeedbackProvider extends BaseApiProvider {
  final model = 'feedback';

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> store(FeedbackModel data) async {
    try {
      final body = feedbackModelToJson(data);
      final response = await post('$model/store', body);
      return responseHandler(response);
    } catch (e) {
      throw e;
    }
  }

  Future<FeedbackListModel> getFeedbackList({int? limit = 20, int? page = 1}) async {
    try {
      final response = await get('$model?limit=$limit&page=$page');
      final result = feedbackListModelFromJson(responseHandler(response));
      return result;
    } catch (e) {
      throw e;
    }
  }
}
