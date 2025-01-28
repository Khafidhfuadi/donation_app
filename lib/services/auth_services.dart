// In your main.dart or a new AuthService
import 'package:donation_app/models/user_donation_stats_model.dart';
import 'package:donation_app/models/user_model.dart';
import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final supabase = Supabase.instance.client;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final Rx<UserDonationStats?> userStats = Rx<UserDonationStats?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    fetchUserInfo();
    fetchUserStats();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // Check Supabase session first
    final session = supabase.auth.currentSession;
    if (session != null) {
      isLoggedIn.value = true;
      await prefs.setBool('isLoggedIn', true);
      Get.offAllNamed(InitScreen.routeName);
      return;
    }

    // Fallback to SharedPreferences
    final storedLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (storedLoggedIn) {
      await logout(); // Clear stale login state
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    await supabase.auth.signOut();
    isLoggedIn.value = false;
    Get.offAllNamed(SignInScreen.routeName);
  }

  //fetch user info
  Future<void> fetchUserInfo() async {
    currentUser.value = null;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    //get all user response

    final response = await supabase
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle(); // Changed from maybeSingle() to single()

    // If no user found, return early
    if (response == null) {
      return;
    }

    final user = UserModel(
      id: response['id'] as String,
      namaLengkap: response['nama_lengkap'] as String,
      nik: response['nik'] as String,
      alamatTinggal: response['alamat_tinggal'] as String,
      noHp: response['no_hp'] as String,
      fotoProfil: response['foto_profil'] as String,
      idDesa: response['id_desa'] as int,
      roleId: response['role_id'] as int,
      jenisKelamin: response['jenis_kelamin'] as String,
    );

    currentUser.value = user;
  }

  Future<void> fetchUserStats() async {
    userStats.value = null;
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    // Using the user_donation_stats view to get all info in one query
    final response = await supabase
        .from('user_donation_stats')
        .select()
        .eq('user_id', userId)
        .maybeSingle(); // Changed from single() to maybeSingle()

    if (response == null) {
      return;
    }

    // Handle type conversion for money_donated
    num moneyDonated = response['total_money_donated'] ?? 0;

    final user = UserDonationStats(
      userId: response['user_id'] as String,
      namaLengkap: response['nama_lengkap'] as String,
      nik: response['nik'] as String,
      totalDonationsMade: (response['total_donations_made'] ?? 0) as int,
      totalMoneyDonated: moneyDonated.toDouble(), // Convert to double safely
      totalGoodsDonations: (response['total_goods_donations'] ?? 0) as int,
      campaignsCreated: (response['campaigns_created'] ?? 0) as int,
      currentQuota: (response['current_quota'] ?? 0) as int,
      anonymousDonationsCount:
          (response['anonymous_donations_count'] ?? 0) as int,
      lastDonationDate: response['last_donation_date'] != null
          ? DateTime.parse(response['last_donation_date'] as String)
          : null,
      firstDonationDate: response['first_donation_date'] != null
          ? DateTime.parse(response['first_donation_date'] as String)
          : null,
      statsGeneratedAt:
          DateTime.parse(response['stats_generated_at'] as String),
    );

    userStats.value = user;
  }
}
