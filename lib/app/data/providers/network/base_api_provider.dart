import 'package:get/get.dart';
import 'package:mrbj_app/app/data/providers/services/storage.service.dart';

class BaseApiProvider extends GetConnect {
  @override
  void onInit() async {
    httpClient.baseUrl = 'https://3caf-114-124-247-77.ngrok.io/';
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = Duration(seconds: 8);

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = this.getAccessToken();
      request.headers['Authorization'] = '${token}';
      return request;
    });
    super.onInit();
  }

  String getAccessToken() {
    try {
      final auth = storageService.getStorage('user');
      return auth['accessToken'];
    } catch (_) {}

    return '';
  }

  responseHandler<T>(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response.bodyString;
      case 500:
        throw {"message": "Mohon maaf, Sepertinya servernya sedang bermasalah. Silahkan coba lagi nanti!"};
      case 400:
      case 422:
      case 401:
      case 403:
        throw response.body;
      default:
        throw {"message": 'Mohon maaf, Sepertinya ada sesuatu yang salah. Silahkan coba lagi nanti!'};
    }
  }
}
