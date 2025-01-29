import 'package:donation_app/screens/home/components/section_title.dart';
import 'package:donation_app/screens/profile_page/profile_page_screen.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/disaster.png", "text": "Bencana Alam"},
      {"icon": "assets/images/edu.png", "text": "Pendidikan"},
      {"icon": "assets/images/health.png", "text": "Kesehatan"},
      {"icon": "assets/images/rice.png", "text": "Pangan"},
      {"icon": "assets/images/road.png", "text": "Infrastruktur"},
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
              title: "Kategori",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePageScreen()),
                );
              }),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF79D7BE),
                    Color.fromARGB(255, 225, 250, 226)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                icon,
                width: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(text,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
