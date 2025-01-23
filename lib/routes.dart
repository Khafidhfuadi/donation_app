import 'package:get/get.dart';
import 'package:donation_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/screens/profile_page/profile_page_screen.dart';
import 'package:donation_app/screens/sign_in/sign_in_screen.dart';
import 'package:donation_app/screens/sign_up/sign_up_screen.dart';
import 'package:donation_app/screens/splash/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: InitScreen.routeName,
      page: () => const InitScreen(),
    ),
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: SignInScreen.routeName,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: ForgotPasswordScreen.routeName,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: SignUpScreen.routeName,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: ProfilePageScreen.routeName,
      page: () => const ProfilePageScreen(),
    ),
  ];
}
