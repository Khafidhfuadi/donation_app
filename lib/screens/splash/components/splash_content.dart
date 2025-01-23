import 'package:flutter/material.dart';

import '../../../constants.dart';

class SplashContent extends StatelessWidget {
  final String? header;
  final String? text;
  final String? image;

  const SplashContent({
    super.key,
    this.header,
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Image.asset(
            image!,
            height: 265,
            width: 235,
          ),
          const Spacer(),
          Text(
            header!,
            style: TextStyle(
              fontSize: 24,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            text!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
