import 'package:donation_app/screens/home/components/donation_lists_card.dart';
import 'package:donation_app/screens/home/components/highlighted_donation_card.dart';
import 'package:flutter/material.dart';

import 'components/categories.dart';
import 'components/donation_info_card.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              const HomeHeader(),
              DonationInfoCard(),
              const Categories(),
              const HighlightedDonation(),
              const DonationProductLists(),
              // const SpecialOffers(),
              // SizedBox(height: 20),
              // PopularProducts(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
