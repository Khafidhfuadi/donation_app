import 'package:donation_app/models/user_donation_stats_model.dart';
import 'package:donation_app/models/user_model.dart';
import 'package:donation_app/screens/init_screen.dart';
import 'package:donation_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final supabase = Supabase.instance.client;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final Rx<UserDonationStats?> userStats = Rx<UserDonationStats?>(null);

  // Add loading states
  final RxBool isLoadingUser = false.obs;
  final RxBool isLoadingStats = false.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  // Make this a synchronous check for the initial route
  void checkLoginStatus() {
    final session = supabase.auth.currentSession;
    if (session != null) {
      isLoggedIn.value = true;
    }
  }

  // Move the async operations to a separate method
  Future<void> _initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final session = supabase.auth.currentSession;

    if (session != null) {
      isLoggedIn.value = true;
      await prefs.setBool('isLoggedIn', true);

      // Fetch user data in background
      Future.wait([
        fetchUserInfo(),
        fetchUserStats(),
      ]);

      if (Get.currentRoute != InitScreen.routeName) {
        Get.offAllNamed(InitScreen.routeName);
      }
      return;
    }

    final storedLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (storedLoggedIn) {
      await logout();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    await supabase.auth.signOut();
    isLoggedIn.value = false;
    currentUser.value = null;
    userStats.value = null;
    Get.offAllNamed(SplashScreen.routeName);
  }

  Future<void> fetchUserInfo() async {
    if (isLoadingUser.value) return; // Prevent multiple simultaneous fetches

    isLoadingUser.value = true;
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response =
          await supabase.from('users').select().eq('id', userId).maybeSingle();

      if (response == null) return;

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
    } finally {
      isLoadingUser.value = false;
    }
  }

  Future<void> fetchUserStats() async {
    if (isLoadingStats.value) return; // Prevent multiple simultaneous fetches

    isLoadingStats.value = true;
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await supabase
          .from('user_donation_stats')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return;

      num moneyDonated = response['total_money_donated'] ?? 0;

      final stats = UserDonationStats(
        userId: response['user_id'] as String,
        namaLengkap: response['nama_lengkap'] as String,
        nik: response['nik'] as String,
        totalDonationsMade: (response['total_donations_made'] ?? 0) as int,
        totalMoneyDonated: moneyDonated.toDouble(),
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

      userStats.value = stats;
    } finally {
      isLoadingStats.value = false;
    }
  }

  // Add a method to fetch all user data in parallel
  Future<void> fetchAllUserData() async {
    await Future.wait([
      fetchUserInfo(),
      fetchUserStats(),
    ]);
  }
}
