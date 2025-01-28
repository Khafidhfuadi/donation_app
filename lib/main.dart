import 'package:donation_app/routes.dart';
import 'package:donation_app/screens/splash/splash_screen.dart';
import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await Supabase.initialize(
    url: 'https://ebcsigcryerjcehgkmdl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImViY3NpZ2NyeWVyamNlaGdrbWRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgwMzkzMzgsImV4cCI6MjA1MzYxNTMzOH0.tC3qU4wmHQOLFGQd6rGR76gl1z9vcIsiD45oRbk6eoQ',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      getPages: AppRoutes.routes,
    );
  }
}
