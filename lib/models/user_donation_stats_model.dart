class UserDonationStats {
  final String userId;
  final String namaLengkap;
  final String nik;
  final int totalDonationsMade;
  final double totalMoneyDonated;
  final int totalGoodsDonations;
  final int campaignsCreated;
  final int currentQuota;
  final int anonymousDonationsCount;
  final DateTime? lastDonationDate; // Made nullable
  final DateTime? firstDonationDate; // Made nullable
  final DateTime statsGeneratedAt;

  UserDonationStats({
    required this.userId,
    required this.namaLengkap,
    required this.nik,
    required this.totalDonationsMade,
    required this.totalMoneyDonated,
    required this.totalGoodsDonations,
    required this.campaignsCreated,
    required this.currentQuota,
    required this.anonymousDonationsCount,
    this.lastDonationDate,
    this.firstDonationDate,
    required this.statsGeneratedAt,
  });
}
