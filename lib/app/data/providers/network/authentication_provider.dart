import 'package:get/state_manager.dart';

import '../../models/authentication.model.dart';
import '../../models/register.model.dart';
import '../services/storage.service.dart';
import 'base_api_provider.dart';

class AuthenticationProvider extends BaseApiProvider {
  RxBool isLoggedIn = false.obs;
  RxBool role = false.obs;
  User? user;

  @override
  void onInit() {
    super.onInit();
  }

  User get userLogged => user!;
  set userLogged(User userLogin) => user = userLogin;

  Future<AuthenticationModel> getAttendance() async {
    try {
      final response = await get('');
      return responseHandler(response);
    } catch (e) {
      throw e;
    }
  }

  Future<AuthenticationModel> login(String email, String password) async {
    try {
      dynamic body = {"email": email, "password": password};
      final response = await post('users/login', body);
      final result = authenticationModelFromJson(responseHandler(response));
      storageService.setStorage('user', result.data);
      isLoggedIn.value = true;
      userLogged = result.data;
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<AuthenticationModel> getDetailUser(String userId) async {
    try {
      dynamic body = {"email": userId};
      final response = await post('users/getDetailUser', body);
      final result = authenticationModelFromJson(responseHandler(response));
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(RegisterModel data) async {
    try {
      final body = registerModelToJson(data);
      final response = await post('users/register', body);
      responseHandler(response);
    } catch (e) {
      throw e;
    }
  }
}
