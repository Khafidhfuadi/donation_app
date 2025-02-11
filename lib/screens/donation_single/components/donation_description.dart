import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants.dart';
import '../../../models/donasi_model.dart';

class DonationDescription extends StatelessWidget {
  DonationDescription({
    super.key,
    required this.donasi,
    this.pressOnSeeMore,
    required this.jumlahDanaTerkumpul,
    required this.durasiDonasi,
    required this.persentase,
  });

  final DonasiModel donasi;
  final String jumlahDanaTerkumpul;
  final int durasiDonasi, persentase;
  final GestureTapCallback? pressOnSeeMore;

  //list dummy donatur terakhir
  final List<Map<String, dynamic>> donaturTerakhir = [
    {
      "nama": "Rizky Fauzan",
      "tanggal": "5 menit yang lalu",
      "jumlah": "Rp 100.000",
    },
    {
      "nama": "Rizky Fauzan",
      "tanggal": "12 menit yang lalu",
      "jumlah": "Rp 100.000",
    },
    {
      "nama": "Rizky Fauzan",
      "tanggal": "1 jam yang lalu",
      "jumlah": "Rp 100.000",
    },
  ];

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Row(
                children: [
                  Image.asset(
                    donasi.isKomoditas
                        ? 'assets/images/commodity.png'
                        : 'assets/images/money.png',
                    width: 16,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    donasi.isKomoditas
                        ? 'Donasi Komoditas (${donasi.detailDonasi!.namaKomoditas ?? ''})'
                        : 'Donasi Uang',
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: kPrimaryColor,
                      size: 16,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(donasi.isKomoditas
                                ? 'Donasi Komoditas'
                                : 'Donasi Uang'),
                            content: Text(donasi.isKomoditas
                                ? 'Donasi komoditas adalah sumbangan berupa barang atau bahan tertentu yang dibutuhkan, seperti Beras, Padi, atau Biji Kopi.'
                                : 'Donasi uang adalah sumbangan berupa uang yang akan digunakan untuk membeli barang atau bahan tertentu yang dibutuhkan.'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              donasi.namaDonasi,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 30, 12),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth * (persentase / 100),
                    height: 8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: kPrimaryLightColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "2387",
                            style: const TextStyle(
                              color: kPrimaryLightColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Donasi",
                        style: TextStyle(
                          color: kPrimaryLightColor.withOpacity(0.5),
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
                  color: kPrimaryLightColor.withOpacity(0.5),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        jumlahDanaTerkumpul,
                        style: const TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Terkumpul",
                        style: TextStyle(
                          color: kPrimaryLightColor.withOpacity(0.5),
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
                  color: kPrimaryLightColor.withOpacity(0.5),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$durasiDonasi hari",
                        style: const TextStyle(
                          color: kPrimaryLightColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Tersisa",
                        style: TextStyle(
                          color: kPrimaryLightColor.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Share.share(
                  "${donasi.namaDonasi}\n\n${donasi.detailDonasi!.ceritaDonasi}\n\nBerikan donasi Anda di https://example.com/donasi/${donasi.id}");
            },
            child: Align(
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
          ),
          // penggalang dana card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: kPrimaryLightColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Penggalang Dana",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Penggalang dana info
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              Image.asset("assets/images/default-profile.png")
                                  .image,
                          radius: 24,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      donasi.penggalangDonasi!.namaLengkap,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.verified_rounded,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Identitas Terverifikasi",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Warga Baik yang Telah Berdonasi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // count pill
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        "2387",
                        style: const TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: donaturTerakhir.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: Image.asset(
                                      "assets/images/default-profile.png")
                                  .image,
                              radius: 20,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  donaturTerakhir[index]["nama"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  donaturTerakhir[index]["tanggal"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              donaturTerakhir[index]["jumlah"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
