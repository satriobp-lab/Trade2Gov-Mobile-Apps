class PibkListDataBarangResponseModel {
  final int serial;
  final String uraianBarang;
  final String kodeHs;
  final double nilaiInvoice;
  final int jumlahKemasan;
  final String? jenisKemasan;
  final double netto;
  final String status;
  final String car;
  final String noHs;

  PibkListDataBarangResponseModel({
    required this.serial,
    required this.uraianBarang,
    required this.kodeHs,
    required this.nilaiInvoice,
    required this.jumlahKemasan,
    this.jenisKemasan,
    required this.netto,
    required this.status,
    required this.car,
    required this.noHs,
  });

  factory PibkListDataBarangResponseModel.fromJson(Map<String, dynamic> json) {
    return PibkListDataBarangResponseModel(
      serial: json['SERIAL'] ?? 0,
      uraianBarang: json['Uraian Barang'] ?? '',
      kodeHs: json['Kode HS'] ?? '',
      nilaiInvoice: (json['Nilai Invoice'] ?? 0).toDouble(),
      jumlahKemasan: json['Jml. Kemasan'] ?? 0,
      jenisKemasan: json['Jns. Kemasan'],
      netto: (json['Netto'] ?? 0).toDouble(),
      status: json['Status'] ?? '',
      car: json['CAR'] ?? '',
      noHs: json['NOHS'] ?? '',
    );
  }
}