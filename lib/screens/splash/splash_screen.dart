import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/splash_content.dart';

class SplashController extends GetxController {
  final RxInt currentPage = 0.obs;

  final List<Map<String, String>> splashData = [
    {
      "header": "Donasi Komoditas Untuk Desa",
      "text":
          "Bagikan hasil bumi, barang atau kebutuhan pokok untuk membantu warga desa sesama.",
      "image": "assets/images/splash_1.png"
    },
    {
      "header": "Donasi Mudah dan Aman",
      "text": "Donasi Uang atau Komoditas? Semua dijamin aman dan praktis",
      "image": "assets/images/splash_2.png"
    },
    {
      "header": "Bersama Untuk Desa",
      "text":
          "Mari Bergabung dalam Perubahan Positif. Dukung Pembangunan Desa dan Tingkatkan Kesejahteraan Warga Desa.",
      "image": "assets/images/splash_3.png"
    },
  ];

  void onPageChanged(int value) {
    currentPage.value = value;
  }

  void navigateToSignIn() {
    Get.toNamed(SignInScreen.routeName);
  }
}

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    final authService = Get.find<AuthService>();

    // Use ever to react to login status changes
    ever(authService.isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        Get.offAllNamed(InitScreen.routeName);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: PageView.builder(
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    header: controller.splashData[index]["header"],
                    image: controller.splashData[index]["image"],
                    text: controller.splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.splashData.length,
                              (index) => AnimatedContainer(
                                duration: kAnimationDuration,
                                margin: const EdgeInsets.only(right: 5),
                                height: 6,
                                width: controller.currentPage.value == index
                                    ? 20
                                    : 6,
                                decoration: BoxDecoration(
                                  color: controller.currentPage.value == index
                                      ? kPrimaryColor
                                      : const Color(0xFFD8D8D8),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          )),
                      const Spacer(flex: 2),
                      ElevatedButton(
                        onPressed: controller.navigateToSignIn,
                        child: const Text("Skip"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
