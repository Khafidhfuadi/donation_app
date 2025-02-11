import 'package:flutter/material.dart';
import 'package:donation_app/constants.dart';

class IsKomoditasPill extends StatelessWidget {
  final bool isKomoditas;
  final String? namaKomoditas;

  const IsKomoditasPill({
    super.key,
    required this.isKomoditas,
    this.namaKomoditas,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              isKomoditas
                  ? 'assets/images/commodity.png'
                  : 'assets/images/money.png',
              width: 16,
              color: kPrimaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              isKomoditas
                  ? 'Donasi Komoditas (${namaKomoditas ?? ''})'
                  : 'Donasi Uang',
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 10,
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
                      title: Text(isKomoditas ? 'Info Komoditas' : 'Info Uang'),
                      content: Text(isKomoditas
                          ? 'Ini adalah donasi komoditas. ${namaKomoditas ?? ''}'
                          : 'Ini adalah donasi uang.'),
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
    );
  }
}
