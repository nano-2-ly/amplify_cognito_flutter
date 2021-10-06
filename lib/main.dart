import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'screens/entry.dart';
import 'screens/confirm.dart';
import 'screens/confirm_reset.dart';
import 'screens/dashboard.dart';
import 'package:get/get.dart';
import 'helpers/configure_amplify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/confirm-reset', page: () => ConfirmResetScreen()),
        GetPage(name: '/confirm', page: () => ConfirmScreen()),
      ],

    );
  }
}
