import 'package:amplify_cognito_flutter/screens/deviceSettingScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/entry.dart';
import 'screens/confirm.dart';
import 'screens/confirm_reset.dart';
import 'screens/dashboard.dart';
import 'screens/deviceScreen.dart';
import 'screens/settingScreen.dart';
import 'package:get/get.dart';
import 'helpers/configure_amplify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _initNotiSetting();

  fcm_ready();
  await configureAmplify();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Amp Awesome',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      ),

      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => EntryScreen()),
        GetPage(name: '/confirm-reset', page: () => ConfirmResetScreen()),
        GetPage(name: '/confirm', page: () => ConfirmScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/device', page: () => deviceScreen()),
        GetPage(name: '/device/setting', page: () => deviceSettingScreen()),
        GetPage(name: '/setting', page: () => settingScreen()),
      ],

    );
  }
}



Future<void> _showNotification(String title, String body) async {
  var _flutterLocalNotificationsPlugin;

  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/launcher_icon');
  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  _flutterLocalNotificationsPlugin.initialize(initializationSettings);

  var android = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);

  var ios = IOSNotificationDetails();
  var detail = NotificationDetails(android: android, iOS: ios);

  await _flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    detail,
    payload: 'Hello Flutter',
  );
}

void fcm_ready() async{
  final FirebaseApp _initialization = await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  await FirebaseMessaging.instance.subscribeToTopic("notification");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification!.body}');
    }
    _showNotification(message.notification!.title.toString(), message.notification!.body.toString());

  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


void _initNotiSetting() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  final initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
}