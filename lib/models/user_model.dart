class UserModel {
  final String id;
  final int? roleId;
  final String namaLengkap;
  final String? nik;
  final String? jenisKelamin;
  final String? alamatTinggal;
  final String? noHp;
  final String? fotoProfil;
  final int? idDesa;

  UserModel({
    required this.id,
    this.roleId,
    required this.namaLengkap,
    this.nik,
    this.jenisKelamin,
    this.alamatTinggal,
    this.noHp,
    this.fotoProfil,
    this.idDesa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      roleId: json['role_id'],
      namaLengkap: json['nama_lengkap'] ?? '',
      nik: json['nik'],
      jenisKelamin: json['jenis_kelamin'],
      alamatTinggal: json['alamat_tinggal'],
      noHp: json['no_hp'],
      fotoProfil: json['foto_profil'],
      idDesa: json['id_desa'],
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'nama_lengkap': namaLengkap,
      'nik': nik,
      'jenis_kelamin': jenisKelamin,
      'alamat_tinggal': alamatTinggal,
      'no_hp': noHp,
      'foto_profil': fotoProfil,
      'id_desa': idDesa,
    };
  }
}
