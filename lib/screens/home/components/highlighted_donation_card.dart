import 'package:donation_app/constants.dart';
import 'package:donation_app/models/donasi_model.dart';
import 'package:donation_app/screens/donation_single/donation_single_screen.dart';
import 'package:donation_app/screens/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class HighlightedDonation extends StatelessWidget {
  final List<DonasiModel> donations;

  const HighlightedDonation({
    super.key,
    required this.donations,
  });

  @override
  Widget build(BuildContext context) {
    final durasiDonasi = donations[0]
        .detailDonasi!
        .tanggalBerakhir
        .difference(donations[0].detailDonasi!.approvedAt)
        .inDays;
    final jumlahDanaTerkumpul =
        "Rp ${donations[0].terkumpul.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    final persentase =
        (donations[0].terkumpul / donations[0].targetDonasi * 100).toInt();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        //categories title
        SectionTitle(
            title: "Bantu Sesama, Pulih Bersama",
            press: () {
              null;
            }),
        Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: HighlitedDonationCard(
              thumbnailDonasi: donations[0].thumbnailDonasi,
              durasiDonasi: "$durasiDonasi hari",
              namaDonasi: donations[0].namaDonasi,
              kategoriDonasi: donations[0].namaKategori,
              penggalangDana: donations[0].penggalangDonasi!.namaLengkap,
              jumlahDanaTerkumpul: jumlahDanaTerkumpul,
              isKomoditas: donations[0].isKomoditas,
              namaKomoditas: donations[0].detailDonasi!.namaKomoditas ?? '',
              thumbnailKat: () {
                String thumbnailKat = "assets/images/health.png";
                switch (donations[0].namaKategori) {
                  case "Bencana Alam":
                    thumbnailKat = "assets/images/disaster.png";
                    break;
                  case "Pendidikan":
                    thumbnailKat = "assets/images/edu.png";
                    break;
                  case "Kesehatan":
                    thumbnailKat = "assets/images/health.png";
                    break;
                  case "Pangan":
                    thumbnailKat = "assets/images/rice.png";
                    break;
                  case "Infrastruktur":
                    thumbnailKat = "assets/images/road.png";
                    break;
                }
                return thumbnailKat;
              }(),
              persentase: persentase,
              press: () {
                Navigator.pushNamed(
                  context,
                  DonationSingleScreen.routeName,
                  arguments: DonationDetailsArguments(
                      donation: donations[0],
                      jumlahDanaTerkumpul: jumlahDanaTerkumpul,
                      durasiDonasi: durasiDonasi,
                      persentase: persentase),
                );
              },
            )),
      ]),
    );
  }
}

class HighlitedDonationCard extends StatelessWidget {
  const HighlitedDonationCard({
    super.key,
    required this.thumbnailDonasi,
    required this.namaDonasi,
    required this.kategoriDonasi,
    required this.penggalangDana,
    required this.jumlahDanaTerkumpul,
    required this.durasiDonasi,
    required this.thumbnailKat,
    required this.press,
    required this.persentase,
    required this.isKomoditas,
    required this.namaKomoditas,
  });

  final String thumbnailDonasi,
      namaDonasi,
      kategoriDonasi,
      penggalangDana,
      jumlahDanaTerkumpul,
      durasiDonasi,
      thumbnailKat,
      namaKomoditas;
  final int persentase;
  final bool isKomoditas;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    thumbnailDonasi,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Show a placeholder when image fails to load
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          kategoriDonasi,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          thumbnailKat,
                          width: 16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isKomoditas)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/commodity.png',
                      width: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Donasi Komoditas ($namaKomoditas)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              "Beri Harapan Pasien Jantung Berjuang Sembuh!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  penggalangDana,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth * (persentase / 100),
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        jumlahDanaTerkumpul,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Terkumpul",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.5),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        durasiDonasi,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Tersisa",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.5),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Share.share(
                        'Donasi untuk $namaDonasi di kategori $kategoriDonasi. Dana terkumpul: $jumlahDanaTerkumpul. Durasi donasi: $durasiDonasi.',
                      );
                    },
                    icon: const Icon(
                      Icons.share_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerHighlitedDonationCard extends StatelessWidget {
  const ShimmerHighlitedDonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPrimaryColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 50,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 1,
                height: 24,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 50,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 1,
                height: 24,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Icon(
                    Icons.share_rounded,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
