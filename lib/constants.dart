import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF2E5077);
const kPrimaryLightColor = Color(0xFF4DA1A9);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 88, 130, 177), Color(0xFF2E5077)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Silakan masukkan email Anda";
const String kInvalidEmailError = "Silakan masukkan email yang valid";
const String kPassNullError = "Silakan masukkan kata sandi Anda";
const String kShortPassError = "Kata sandi terlalu pendek";
const String kMatchPassError = "Kata sandi tidak cocok";
const String kNamelNullError = "Silakan masukkan nama Anda";
const String kPhoneNumberNullError = "Silakan masukkan nomor telepon Anda";
const String kAddressNullError = "Silakan masukkan alamat Anda";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
