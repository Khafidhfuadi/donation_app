import 'package:donation_app/models/donation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class DonationServices extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<DonationModel> donations = <DonationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  Future<void> fetchDonations() async {
    if (isLoading.value) return; // Prevent multiple simultaneous fetches

    isLoading.value = true;
    try {
      final response = await supabase.from('donations').select();

      final data = response.toList();
      donations.assignAll(data.map((e) => DonationModel.fromJson(e)).toList());
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
