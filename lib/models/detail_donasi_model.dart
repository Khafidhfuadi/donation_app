class DetailDonasiModel {
  final int id;
  final String ceritaDonasi;
  final DateTime tanggalBerakhir;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime approvedAt;
  final String? namaKomoditas;

  DetailDonasiModel({
    required this.id,
    required this.ceritaDonasi,
    required this.tanggalBerakhir,
    required this.createdAt,
    required this.updatedAt,
    required this.approvedAt,
    this.namaKomoditas,
  });

  factory DetailDonasiModel.fromJson(Map<String, dynamic> json) {
    return DetailDonasiModel(
      id: json['id'] as int,
      ceritaDonasi: json['cerita_donasi'] as String,
      tanggalBerakhir: DateTime.parse(json['tanggal_berakhir']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      approvedAt: DateTime.parse(json['approved_at']),
      namaKomoditas: json['nama_komoditas'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cerita_donasi': ceritaDonasi,
      'tanggal_berakhir': tanggalBerakhir.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'approved_at': approvedAt.toIso8601String(),
      'nama_komoditas': namaKomoditas,
    };
  }
}
