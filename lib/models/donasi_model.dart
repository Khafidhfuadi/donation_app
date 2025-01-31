import 'package:donation_app/models/detail_donasi_model.dart';

class DonasiModel {
  final int id;
  final String namaKategori;
  final String namaDonasi;
  final double terkumpul;
  final double targetDonasi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String namaPenggalang;
  final String thumbnailDonasi;
  final DetailDonasiModel? detailDonasi;
  final bool isKomoditas;

  DonasiModel({
    required this.id,
    required this.namaKategori,
    required this.namaDonasi,
    required this.terkumpul,
    required this.targetDonasi,
    required this.createdAt,
    required this.updatedAt,
    required this.namaPenggalang,
    required this.thumbnailDonasi,
    this.detailDonasi,
    required this.isKomoditas,
  });

  factory DonasiModel.fromJson(Map<String, dynamic> json) {
    final kategoriDonasi = json['kategori_donasi_id'] as Map<String, dynamic>;
    final user = json['user_id'] as Map<String, dynamic>;
    final detailDonasiList = json['detail_donasi'] as List;

    // Get the first detail_donasi if available
    DetailDonasiModel? detailDonasi;
    if (detailDonasiList.isNotEmpty) {
      detailDonasi = DetailDonasiModel.fromJson(
          detailDonasiList.first as Map<String, dynamic>);
    }

    return DonasiModel(
      id: json['id'] as int,
      namaKategori: kategoriDonasi['nama_kategori'] as String,
      namaDonasi: json['nama_donasi'] as String,
      terkumpul: (json['terkumpul'] ?? 0.0).toDouble(),
      targetDonasi: (json['target_donasi'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      namaPenggalang: user['nama_lengkap'] as String? ?? '',
      thumbnailDonasi: json['thumbnail_donasi'] as String? ?? '',
      detailDonasi: detailDonasi,
      isKomoditas: json['is_komoditas'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_donasi': namaDonasi,
      'terkumpul': terkumpul,
      'target_donasi': targetDonasi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'thumbnail_donasi': thumbnailDonasi,
      'kategori_donasi_id': {'nama_kategori': namaKategori},
      'user_id': {'nama_lengkap': namaPenggalang},
      'detail_donasi': detailDonasi?.toJson(),
      'is_komoditas': isKomoditas,
    };
  }
}
