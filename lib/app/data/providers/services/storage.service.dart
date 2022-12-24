import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  @override
  void onInit() async {
    await GetStorage.init();
    super.onInit();
  }

  void setStorage(String key, dynamic value) {
    final box = GetStorage();
    box.write(key, jsonEncode(value));
  }

  T getStorage<T>(String key) {
    final box = GetStorage();
    final read = box.read(key);
    return read != null ? jsonDecode(read) : read;
  }

  void removeStorage(key) {
    final box = GetStorage();
    box.remove(key);
  }

  void clearStorage() {
    final box = GetStorage();
    box.erase();
  }
}

StorageService storageService = StorageService();
