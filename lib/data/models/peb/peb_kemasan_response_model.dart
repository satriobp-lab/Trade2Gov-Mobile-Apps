class PebKemasanResponseModel {
  final String? kemasan;      // "BX - Box"
  final String? merkKemasan;  // "AA08TC/AA20RC"
  final int? jumlahKemasan;   // 68
  final String? jenisKemasan; // "BX"
  final String? car;

  PebKemasanResponseModel({
    this.kemasan,
    this.merkKemasan,
    this.jumlahKemasan,
    this.jenisKemasan,
    this.car,
  });

  factory PebKemasanResponseModel.fromJson(Map<String, dynamic> json) {
    return PebKemasanResponseModel(
      kemasan: json['KEMASAN'],
      merkKemasan: json['MERKKEMAS'],
      jumlahKemasan: json['JMKEMAS'],
      jenisKemasan: json['JNKEMAS'],
      car: json['CAR'],
    );
  }

  /// Helper ambil nama kemasan dari "BX - Box"
  String get namaKemasan {
    if (kemasan == null || !kemasan!.contains('-')) return '-';
    return kemasan!.split('-').last.trim();
  }

  /// Helper ambil kode dari "BX - Box"
  String get kodeKemasan {
    if (kemasan == null || !kemasan!.contains('-')) return '-';
    return kemasan!.split('-').first.trim();
  }
}