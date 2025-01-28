import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'Khafidh Fuadi'.obs;
  final RxString userEmail = 'khafidhfuadi0173@gmail.com'.obs;
  final RxString userAvatar =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/netron-e-com-mobile-6rhojr/assets/l260dcr57pr2/user-default.png'
          .obs;
  final AuthService authService = Get.find();

  void navigateToEditProfile() {
    Get.toNamed('/profile-edit');
  }

  void navigateToVerifyIdentity() {
    Get.toNamed('/verify-identity');
  }

  void navigateToSavedDonations() {
    Get.toNamed('/saved-donations');
  }

  void navigateToAboutUs() {
    Get.toNamed('/about-us');
  }

  void navigateToFAQ() {
    Get.toNamed('/help-center');
  }

  void navigateToContactUs() {
    Get.toNamed('/contact');
  }

  void showLogoutConfirmation() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      onConfirm: () {
        authService.logout();
      },
      onCancel: () {},
    );
  }
}

class ProfilePageScreen extends StatelessWidget {
  static String routeName = "/profile_page";

  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileHeader(controller),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              _buildProfileMenuSection(controller),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Version 1.0.01 Build 21',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileController controller) {
    return Column(
      children: [
        Obx(() => CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                controller.userAvatar.value,
              ),
            )),
        const SizedBox(height: 12),
        Obx(() => Text(
              controller.userName.value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            )),
        const SizedBox(height: 8),
        Obx(() => Text(
              controller.userEmail.value,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )),
      ],
    );
  }

  Widget _buildProfileMenuSection(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: controller.navigateToEditProfile,
          ),
          _buildMenuItem(
            icon: Icons.verified,
            title: 'Verify Identity',
            onTap: controller.navigateToVerifyIdentity,
          ),
          _buildMenuItem(
            icon: Icons.favorite,
            title: 'Saved Donations',
            onTap: controller.navigateToSavedDonations,
          ),
          const Divider(),
          _buildMenuItem(
            icon: Icons.people,
            title: 'About Us',
            onTap: controller.navigateToAboutUs,
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: 'FAQ',
            onTap: controller.navigateToFAQ,
          ),
          _buildMenuItem(
            icon: Icons.chat,
            title: 'Contact Us',
            onTap: controller.navigateToContactUs,
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: controller.showLogoutConfirmation,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
