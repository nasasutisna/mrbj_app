import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:mrbj_app/app/data/providers/network/authentication_provider.dart';

import 'app/data/models/authentication.model.dart';
import 'app/data/providers/services/push-notification.service.dart';
import 'app/data/providers/services/storage.service.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await initStorageService();
  initializePushNotif();

  runApp(
    GetMaterialApp(
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      title: "MRBJAPP",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Locale('in'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('in')],
    ),
  );
}

Future<void> initStorageService() async {
  Get.putAsync(() async => await StorageService());
  await Future.delayed(Duration(milliseconds: 200));
  AuthenticationProvider authenticationProvider = Get.put(AuthenticationProvider());
  final result = storageService.getStorage('user');
  if (result != null) {
    User user = User.fromJson(result);
    authenticationProvider.userLogged = user;
  }
}

initializePushNotif() {
  PushNotificationService pushNotificationService = PushNotificationService();
  pushNotificationService.registerNotification();
}
