import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/donasi_model.dart';

class DonationDescription extends StatelessWidget {
  const DonationDescription({
    super.key,
    required this.donasi,
    this.pressOnSeeMore,
  });

  final DonasiModel donasi;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              donasi.namaDonasi,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(14),
              width: 48,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/share.svg",
                colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
                height: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 64,
            ),
            child: Text(
              donasi.detailDonasi!.ceritaDonasi,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: GestureDetector(
              onTap: pressOnSeeMore,
              child: const Row(
                children: [
                  Text(
                    "Baca Cerita Lengkap",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
