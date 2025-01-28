import 'package:donation_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HighlightedDonation extends StatelessWidget {
  const HighlightedDonation({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> datas = [
      {
        "thumbnail_donasi":
            "https://i.ibb.co.com/RykKXdp/b53b21e3-4bb8-4d27-bfd7-2a062df00bf6.jpg",
        "nama_donasi": "Banjir Bandung",
        "kategori_donasi": "Bencana Alam",
        "penggalang_dana": "Yayasan Bencana Alam",
        "jumlah_dana_terkumpul": "Rp 1.000.000",
        "durasi_donasi": "7 hari lagi",
      },
      {
        "thumbnail_donasi":
            "https://i.ibb.co.com/RykKXdp/b53b21e3-4bb8-4d27-bfd7-2a062df00bf6.jpg",
        "nama_donasi": "Gempa Lombok",
        "kategori_donasi": "Bencana Alam",
        "penggalang_dana": "Yayasan Peduli Lombok",
        "jumlah_dana_terkumpul": "Rp 2.500.000",
        "durasi_donasi": "10 hari lagi",
      },
      {
        "thumbnail_donasi":
            "https://i.ibb.co.com/RykKXdp/b53b21e3-4bb8-4d27-bfd7-2a062df00bf6.jpg",
        "nama_donasi": "Kebakaran Hutan",
        "kategori_donasi": "Bencana Alam",
        "penggalang_dana": "Yayasan Alam Lestari",
        "jumlah_dana_terkumpul": "Rp 3.000.000",
        "durasi_donasi": "5 hari lagi",
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          //categories title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bantu Sesama, Pulih Bersama",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(
              datas.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: HighlitedDonationCard(
                  thumbnailDonasi: datas[index]["thumbnail_donasi"],
                  namaDonasi: datas[index]["nama_donasi"],
                  kategoriDonasi: datas[index]["kategori_donasi"],
                  penggalangDana: datas[index]["penggalang_dana"],
                  jumlahDanaTerkumpul: datas[index]["jumlah_dana_terkumpul"],
                  durasiDonasi: datas[index]["durasi_donasi"],
                  press: () {},
                ),
              ),
            ),
          ),
        ],
      ),
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
    required this.press,
  });

  final String thumbnailDonasi,
      namaDonasi,
      kategoriDonasi,
      penggalangDana,
      jumlahDanaTerkumpul,
      durasiDonasi;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPrimaryColor.withAlpha((0.1 * 255).toInt()),
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
                      color: const Color.fromRGBO(77, 161, 169, 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      kategoriDonasi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 4),
            Text(
              namaDonasi,
              style: const TextStyle(
                color: kTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(penggalangDana,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14,
                    )),
                const SizedBox(width: 4),
                Icon(
                  Icons.verified_rounded,
                  color: kPrimaryColor,
                  size: 20,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        jumlahDanaTerkumpul,
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Terkumpul",
                        style: TextStyle(
                          color: Color.fromRGBO(
                            kTextColor.r.toInt(),
                            kTextColor.g.toInt(),
                            kTextColor.b.toInt(),
                            0.5,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                //border
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 1,
                  height: 24,
                  color: Color.fromRGBO(
                    kTextColor.r.toInt(),
                    kTextColor.g.toInt(),
                    kTextColor.b.toInt(),
                    0.5,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        durasiDonasi,
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Tersisa",
                        style: TextStyle(
                          color: Color.fromRGBO(
                            kTextColor.r.toInt(),
                            kTextColor.g.toInt(),
                            kTextColor.b.toInt(),
                            0.5,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                //border
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 1,
                  height: 24,
                  color: Color.fromRGBO(
                    kTextColor.r.toInt(),
                    kTextColor.g.toInt(),
                    kTextColor.b.toInt(),
                    0.5,
                  ),
                ),
                // share icon button
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Share.share(
                        'Donasi untuk $namaDonasi di kategori $kategoriDonasi. Dana terkumpul: $jumlahDanaTerkumpul. Durasi donasi: $durasiDonasi.',
                      );
                    },
                    icon: const Icon(
                      Icons.share_rounded,
                      color: kTextColor,
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
