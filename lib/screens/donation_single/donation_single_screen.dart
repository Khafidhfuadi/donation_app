import 'package:donation_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/donasi_model.dart';
import 'components/donation_description.dart';
import 'components/donation_images.dart';
import 'components/top_rounded_container.dart';

class DonationSingleScreen extends StatelessWidget {
  static String routeName = "/details";

  const DonationSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as DonationDetailsArguments;
    final donation = args.donation;
    final jumlahDanaTerkumpul = args.jumlahDanaTerkumpul;
    final durasiDonasi = args.durasiDonasi;
    final persentase = args.persentase;

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                DonationImages(donation: donation),
                DonationDescription(
                  donasi: donation,
                  jumlahDanaTerkumpul: jumlahDanaTerkumpul,
                  durasiDonasi: durasiDonasi,
                  persentase: persentase,
                  pressOnSeeMore: () {},
                ),
              ],
            ),
          ),

          // AppBar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                final scrollOffset = scrollController.offset;
                final appBarColor =
                    scrollOffset > 50 ? kPrimaryLightColor : Colors.transparent;
                // final iconColor =
                //     scrollOffset > 50 ? Colors.black : Colors.white;
                final double elevationValue = scrollOffset > 50 ? 1 : 0;

                return AppBar(
                  backgroundColor: appBarColor,
                  elevation: elevationValue,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        elevation: 1,
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Text(
                                donation.namaKategori,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset("assets/icons/Star Icon.svg"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: kPrimaryLightColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: ElevatedButton(
              onPressed: () {
                null;
              },
              child: const Text("Donasi Sekarang"),
            ),
          ),
        ),
      ),
    );
  }
}

class DonationDetailsArguments {
  final DonasiModel donation;
  final String jumlahDanaTerkumpul;
  final int durasiDonasi, persentase;

  DonationDetailsArguments(
      {required this.donation,
      required this.jumlahDanaTerkumpul,
      required this.durasiDonasi,
      required this.persentase});
}
