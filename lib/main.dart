import 'package:donation_app/routes.dart';
import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: InitScreen.routeName,
      getPages: AppRoutes.routes,
    );
  }
}
