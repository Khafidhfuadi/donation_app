// Update DonationInfoCard to use the user information
import 'package:donation_app/constants.dart';
import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationInfoCard extends GetView<AuthService> {
  const DonationInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userInfo = controller.currentUser.value;
      final userStats = controller.userStats.value;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kPrimaryGradientColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Halo, ${userInfo?.namaLengkap}!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoTile(
                  'assets/images/solidarity.png',
                  'Rp ${userStats?.totalMoneyDonated.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.') ?? '0'}',
                  'Total Donasimu',
                ),
                _buildInfoTile(
                  'assets/images/charity.png',
                  '${userStats?.totalDonationsMade ?? 0}x',
                  'Berdonasi',
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoTile(String imagePath, String value, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 221, 87, 77),
                Color.fromARGB(255, 238, 158, 158)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
