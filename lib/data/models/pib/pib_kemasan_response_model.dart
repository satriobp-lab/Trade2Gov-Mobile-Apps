class PibKemasanResponseModel {
  final int? jumlah;
  final String? seri;
  final String? kode;
  final String? merk;
  final String? car;

  PibKemasanResponseModel({
    required this.jumlah,
    this.seri,
    this.kode,
    this.merk,
    this.car,
  });

  factory PibKemasanResponseModel.fromJson(Map<String, dynamic> json) {
    return PibKemasanResponseModel(
      jumlah: json['JUMLAH'],
      seri: json['SERI'],
      kode: json['KODE'],
      merk: json['MERK'],
      car: json['CAR'],
    );
  }

  /// Jumlah aman
  String get jumlahDisplay {
    if (jumlah == null) return '-';
    return jumlah.toString();
  }

  /// Seri aman
  String get seriDisplay {
    if (seri == null || seri!.trim().isEmpty) return '-';
    return seri!;
  }

  /// Ambil nama kemasan (kanan dari "PK - Package")
  String get namaKemasan {
    if (kode == null || kode!.trim().isEmpty) return '-';

    if (kode!.contains(' - ')) {
      final parts = kode!.split(' - ');
      if (parts.length > 1 && parts[1].trim().isNotEmpty) {
        return parts[1].trim();
      }
    }

    return kode!;
  }

  /// Ambil jenis kemasan (kiri dari "PK - Package")
  String get jenisKemasan {
    if (kode == null || kode!.trim().isEmpty) return '-';

    if (kode!.contains(' - ')) {
      final parts = kode!.split(' - ');
      if (parts.isNotEmpty && parts[0].trim().isNotEmpty) {
        return parts[0].trim();
      }
    }

    return kode!;
  }

  /// Merk diformat + null safe
  String get formattedMerk {
    if (merk == null || merk!.trim().isEmpty) return '-';

    return merk!
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .join(', ');
  }
}