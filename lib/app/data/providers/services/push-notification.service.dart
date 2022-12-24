import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class PushNotificationService {
  late final FirebaseMessaging _messaging;
  PushNotificationService();
  PushNotification? notificationInfo;
  String? token;

  void registerNotification() async {
    print('registerNotification');
    // 1. Initialize the Firebase app
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyD7pG6wJc86xbxi-RL09GFQELjSt1Fv3uc',
            appId: '1:966272703281:android:f44873c98fe7b257f2ee10',
            messagingSenderId: '966272703281',
            projectId: 'mrbj-364307'));
    print('registerNotification done');
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      getToken();

      await FirebaseMessaging.instance.subscribeToTopic('kajian');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('messagae ${message.notification?.title}');
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        notificationInfo = notification;
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String> getToken() async {
    try {
      var result = await FirebaseMessaging.instance.getToken();
      print('token $token');
      return result!;
    } catch (e) {
      print('error token $e');
      return '';
    }
  }
}
