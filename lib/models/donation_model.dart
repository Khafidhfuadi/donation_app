class DonationModel {
  int id;
  int? kategoriDonasiId;
  String namaDonasi;
  double terkumpul;
  double targetDonasi;
  DateTime createdAt;
  DateTime updatedAt;
  String? userId;
  String? thumbnailDonasi;

  DonationModel({
    required this.id,
    this.kategoriDonasiId,
    required this.namaDonasi,
    this.terkumpul = 0.0,
    required this.targetDonasi,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.userId,
    this.thumbnailDonasi,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      kategoriDonasiId: json['kategori_donasi_id'],
      namaDonasi: json['nama_donasi'],
      terkumpul: json['terkumpul'] ?? 0.0,
      targetDonasi: json['target_donasi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'],
      thumbnailDonasi: json['thumbnail_donasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kategori_donasi_id': kategoriDonasiId,
      'nama_donasi': namaDonasi,
      'terkumpul': terkumpul,
      'target_donasi': targetDonasi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
      'thumbnail_donasi': thumbnailDonasi,
    };
  }
}
