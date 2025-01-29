import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/screens/sign_in/sign_in_screen.dart';
import 'package:donation_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool remember = false.obs;
  final RxList<String> errors = <String>[].obs;
  final RxBool isLoading = false.obs;

  final supabase = Supabase.instance.client;

  void addError(String? error) {
    if (error != null && !errors.contains(error)) {
      errors.add(error);
    }
  }

  void removeError(String? error) {
    if (error != null && errors.contains(error)) {
      errors.remove(error);
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      addError(kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      addError(kInvalidEmailError);
      return "";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      addError(kPassNullError);
      return "";
    }
    return null;
  }

  void onEmailChanged(String value) {
    if (value.isNotEmpty) {
      removeError(kEmailNullError);
    }
    if (emailValidatorRegExp.hasMatch(value)) {
      removeError(kInvalidEmailError);
    }
    email.value = value;
  }

  void onPasswordChanged(String value) {
    if (value.isNotEmpty) {
      removeError(kPassNullError);
    }
    if (value.length >= 8) {
      removeError(kShortPassError);
    }
    password.value = value;
  }

  Future<void> submitForm() async {
    // Clear previous errors
    errors.clear();

    // Validate form
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(Get.context!);

      // Start loading
      isLoading.value = true;

      try {
        await supabase.auth.signInWithPassword(
          email: email.value.trim(),
          password: password.value.trim(),
        );

        // Explicitly set login state in AuthService
        final authService = Get.find<AuthService>();
        authService.isLoggedIn.value = true;

        if (remember.value) {
          await _saveLoginState();
        }

        await authService.fetchAllUserData();

        // Navigate to initial screen on successful login
        Get.toNamed(InitScreen.routeName);
      } on AuthException catch (e) {
        // Handle specific Supabase authentication errors
        String errorMessage = 'Login failed';
        switch (e.message) {
          case 'Invalid login credentials':
            errorMessage = 'Email atau password salah';
            break;
          case 'Email not confirmed':
            errorMessage = 'Email belum dikonfirmasi';
            break;
          default:
            errorMessage = e.message;
        }

        // Add the error to be displayed
        addError(errorMessage);
      } catch (e) {
        // Catch any other unexpected errors
        addError('Terjadi kesalahan. Coba lagi.');
      } finally {
        // Stop loading
        isLoading.value = false;
      }
    }
  }

  Future<void> _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email.value);
  }

  // Add a logout method
  Future<void> logout() async {
    await supabase.auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    Get.offAllNamed(SignInScreen.routeName);
  }

  void navigateToForgotPassword() {
    Get.toNamed(ForgotPasswordScreen.routeName);
  }
}

class SignForm extends StatelessWidget {
  const SignForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignFormController());

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => controller.email.value = newValue ?? '',
            onChanged: controller.onEmailChanged,
            validator: controller.emailValidator,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Masukkan email kamu",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => controller.password.value = newValue ?? '',
            onChanged: controller.onPasswordChanged,
            validator: controller.passwordValidator,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Masukkan password kamu",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Obx(() => Checkbox(
                    value: controller.remember.value,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      controller.remember.value = value ?? false;
                    },
                  )),
              const Text("Ingat saya"),
              const Spacer(),
              GestureDetector(
                onTap: controller.navigateToForgotPassword,
                child: const Text(
                  "Lupa password?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          Obx(() => FormError(errors: controller.errors.toList())),
          const SizedBox(height: 16),
          Obx(() => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.submitForm,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Masuk"),
              )),
        ],
      ),
    );
  }
}
