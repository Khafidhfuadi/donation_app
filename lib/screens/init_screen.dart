import 'package:donation_app/constants.dart';
import 'package:donation_app/screens/home/home_screen.dart';
import 'package:donation_app/screens/profile_page/profile_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    // const HomeScreen(),
    // const FavoriteScreen(),
    const HomeScreen(),
    const Center(
      child: Text("Fav"),
    ),
    const Center(
      child: Text("Chat"),
    ),
    const ProfilePageScreen(),
    // const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        selectedItemColor: kPrimaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              width: 28,
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/home.svg",
              width: 28,
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
                width: 28, "assets/images/care.png", color: inActiveIconColor),
            activeIcon: Image.asset(
              width: 28,
              "assets/images/care.png",
              color: kPrimaryColor,
            ),
            label: "Donasi Saya",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              width: 28,
              "assets/icons/notif.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              width: 28,
              "assets/icons/notif.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Notifikasi",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
                width: 28,
                "assets/images/person-2.png",
                color: inActiveIconColor),
            activeIcon: Image.asset(
              width: 28,
              "assets/images/person-2.png",
              color: kPrimaryColor,
            ),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
