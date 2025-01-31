import 'package:donation_app/models/donasi_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class DonationServices extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<DonasiModel> donations = <DonasiModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  Future<void> fetchDonations() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final response = await supabase.from('donasi').select('''
            *,
            detail_donasi (
              id,
              cerita_donasi,
              tanggal_berakhir,
              nama_komoditas,
              created_at,
              updated_at,
              approved_at
            ),
            kategori_donasi_id (nama_kategori),
            user_id (nama_lengkap)
            ''').order('updated_at', ascending: false);

      final data = response.toList();
      print('data donasi: $data');
      donations.assignAll(data.map((e) => DonasiModel.fromJson(e)).toList());
    } finally {
      isLoading.value = false;
    }
  }
}
