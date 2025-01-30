import 'package:flutter/material.dart';

import '../../../models/donasi_model.dart';

class DonationImages extends StatelessWidget {
  const DonationImages({
    super.key,
    required this.donation,
  });

  final DonasiModel donation;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      donation.thumbnailDonasi,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Show a placeholder when image fails to load
        return Container(
          width: double.infinity,
          height: 250,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported),
        );
      },
    );
  }
}
