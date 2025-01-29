import 'package:donation_app/constants.dart';
import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DonationInfoCard extends StatelessWidget {
  final AuthService controller = Get.find();

  DonationInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                if (controller.currentUser.value == null)
                  Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      width: 160,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    "Halo, ${controller.currentUser.value!.namaLengkap}!",
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
            if (controller.userStats.value != null) // Add null check here
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoTile(
                    'assets/images/solidarity.png',
                    'Rp ${controller.userStats.value!.totalMoneyDonated.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    'Total Donasimu',
                  ),
                  _buildInfoTile(
                    'assets/images/charity.png',
                    '${controller.userStats.value!.totalDonationsMade}x',
                    'Berdonasi',
                  ),
                ],
              )
            else // Add loading shimmer when stats are null
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLoadingInfoTile(),
                  _buildLoadingInfoTile(),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _buildLoadingInfoTile() {
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
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey[300]!,
              child: Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: Colors.white70,
              highlightColor: Colors.grey[300]!,
              child: Container(
                width: 60,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
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
