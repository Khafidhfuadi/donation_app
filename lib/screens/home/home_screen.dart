import 'package:donation_app/screens/home/components/donation_lists_card.dart';
import 'package:donation_app/screens/home/components/highlighted_donation_card.dart';
import 'package:donation_app/services/donation_services.dart';
import 'package:flutter/material.dart';

import 'components/categories.dart';
import 'components/donation_info_card.dart';
import 'components/home_header.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final donationServices = Get.find<DonationServices>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => donationServices.isLoading.value
              ? Column(
                  children: [
                    const HomeHeader(),
                    DonationInfoCard(),
                    const Categories(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ShimmerHighlitedDonationCard(),
                    ),
                    Column(
                      children: [
                        Row(
                          //center
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 52) / 2,
                              child: DonationListsCardShimmer(),
                            ),
                            SizedBox(width: 12),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 52) / 2,
                              child: DonationListsCardShimmer(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    )
                  ],
                )
              : Column(
                  children: [
                    const HomeHeader(),
                    DonationInfoCard(),
                    const Categories(),
                    HighlightedDonation(donations: donationServices.donations),
                    DonationProductLists(donations: donationServices.donations),
                  ],
                )),
        ),
      ),
    );
  }
}
