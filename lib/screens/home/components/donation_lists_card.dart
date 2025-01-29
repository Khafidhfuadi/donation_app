import 'package:donation_app/constants.dart';
import 'package:flutter/material.dart';

class DonationProductLists extends StatelessWidget {
  const DonationProductLists({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> datas = [
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/disaster.png",
        "nama_donasi": "Dampingi Tumbuh Kembang Setiap Anak Indonesia",
        "kategori_donasi": "Bencana Alam",
        "penggalang_dana": "Yayasan Bencana Alam",
        "jumlah_dana_terkumpul": "Rp1.000.000",
        "durasi_donasi": "7 hari",
      },
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/edu.png",
        "nama_donasi": "Jemput Kemuliaan Santuni Anak Yatim Bisa Sekolah!",
        "kategori_donasi": "Pendidikan",
        "penggalang_dana": "Yayasan Peduli Lombok",
        "jumlah_dana_terkumpul": "Rp2.500.000",
        "durasi_donasi": "10 hari",
      },
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/health.png",
        "nama_donasi": "Sakit Sebatang Kara, Bantu Kakek Bisa Berobat!",
        "kategori_donasi": "Kesehatan",
        "penggalang_dana": "Yayasan Alam Lestari",
        "jumlah_dana_terkumpul": "Rp3.000.000",
        "durasi_donasi": "5 hari",
      },
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/disaster.png",
        "nama_donasi": "Dampingi Tumbuh Kembang Setiap Anak Indonesia",
        "kategori_donasi": "Bencana Alam",
        "penggalang_dana": "Yayasan Bencana Alam",
        "jumlah_dana_terkumpul": "Rp1.000.000",
        "durasi_donasi": "7 hari",
      },
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/edu.png",
        "nama_donasi": "Jemput Kemuliaan Santuni Anak Yatim Bisa Sekolah!",
        "kategori_donasi": "Pendidikan",
        "penggalang_dana": "Yayasan Peduli Lombok",
        "jumlah_dana_terkumpul": "Rp2.500.000",
        "durasi_donasi": "10 hari",
      },
      {
        "thumbnail_donasi": "assets/images/thumb-donation.jpg",
        "thumbnail_kat": "assets/images/health.png",
        "nama_donasi": "Sakit Sebatang Kara, Bantu Kakek Bisa Berobat!",
        "kategori_donasi": "Kesehatan",
        "penggalang_dana": "Yayasan Alam Lestari",
        "jumlah_dana_terkumpul": "Rp3.000.000",
        "durasi_donasi": "5 hari",
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: datas.map((data) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 52) / 2,
                child: DonationListsCard(
                  thumbnailDonasi: data["thumbnail_donasi"],
                  namaDonasi: data["nama_donasi"],
                  kategoriDonasi: data["kategori_donasi"],
                  penggalangDana: data["penggalang_dana"],
                  jumlahDanaTerkumpul: data["jumlah_dana_terkumpul"],
                  durasiDonasi: data["durasi_donasi"],
                  thumbnailKat: data["thumbnail_kat"],
                  press: () {},
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
    required this.press,
  });

  final String thumbnailDonasi,
      namaDonasi,
      kategoriDonasi,
      penggalangDana,
      jumlahDanaTerkumpul,
      durasiDonasi,
      thumbnailKat;
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
                  child: Image.asset(
                    thumbnailDonasi,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
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
            const SizedBox(height: 8),
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
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 14,
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
                    width: constraints.maxWidth * 0.5,
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

//shimmer
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
        mainAxisSize: MainAxisSize.min, // Allow the column to shrink
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
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
                    color: const Color.fromRGBO(77, 161, 169, 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 12,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 2),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * 0.5,
                  height: 8,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
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
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey[300],
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
