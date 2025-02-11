import 'package:donation_app/constants.dart';
import 'package:donation_app/models/donasi_model.dart';
import 'package:donation_app/screens/donation_single/donation_single_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DonationProductLists extends StatelessWidget {
  final List<DonasiModel> donations;

  const DonationProductLists({
    super.key,
    required this.donations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: donations.map((data) {
              //switch icon thumbnailkat based on data.namaKategori
              String thumbnailKat = "assets/images/health.png";
              final durasiDonasi = data.detailDonasi!.tanggalBerakhir
                  .difference(data.detailDonasi!.approvedAt)
                  .inDays;
              final jumlahDanaTerkumpul =
                  "Rp ${data.terkumpul.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
              final persentase =
                  (donations[0].terkumpul / donations[0].targetDonasi * 100)
                      .toInt();
              switch (data.namaKategori) {
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
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 52) / 2,
                child: DonationListsCard(
                  thumbnailDonasi: data.thumbnailDonasi,
                  durasiDonasi: "$durasiDonasi hari",
                  namaDonasi: data.namaDonasi,
                  kategoriDonasi: data.namaKategori,
                  penggalangDana: data.penggalangDonasi!.namaLengkap,
                  jumlahDanaTerkumpul: jumlahDanaTerkumpul,
                  thumbnailKat: thumbnailKat,
                  isKomoditas: data.isKomoditas,
                  namaKomoditas: data.detailDonasi!.namaKomoditas ?? "",
                  persentase: persentase,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      DonationSingleScreen.routeName,
                      arguments: DonationDetailsArguments(
                          donation: data,
                          jumlahDanaTerkumpul: jumlahDanaTerkumpul,
                          durasiDonasi: durasiDonasi,
                          persentase: persentase),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DonationListsCard extends StatelessWidget {
  const DonationListsCard({
    super.key,
    required this.thumbnailDonasi,
    required this.namaDonasi,
    required this.kategoriDonasi,
    required this.penggalangDana,
    required this.jumlahDanaTerkumpul,
    required this.durasiDonasi,
    required this.thumbnailKat,
    required this.persentase,
    required this.press,
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

  final bool isKomoditas;

  final int persentase;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Allow the column to shrink
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    thumbnailDonasi,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Show a placeholder when image fails to load
                      return Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          kategoriDonasi,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          thumbnailKat,
                          width: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            if (isKomoditas)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/commodity.png',
                      width: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Donasi Komoditas',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            if (!isKomoditas)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/money.png',
                      width: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Donasi Uang',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 4),
            Text(
              namaDonasi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(penggalangDana,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    )),
                const SizedBox(width: 2),
                const Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth * (persentase / 100),
                    height: 4,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jumlahDanaTerkumpul,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Terkumpul",
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.5 * 255).toInt()),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        durasiDonasi,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Tersisa",
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.5 * 255).toInt()),
                          fontSize: 10,
                        ),
                      ),
                    ],
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

class DonationListsCardShimmer extends StatelessWidget {
  const DonationListsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 12,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 2),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 10,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
