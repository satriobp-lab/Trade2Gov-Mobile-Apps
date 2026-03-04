class PibkHargaResponseModel {
  final String? kdVal;
  final String? urKdVal;
  final double? ndpbm;
  final double? cif;
  final double? asuransi;
  final double? freight;
  final double? cifRp;
  final double? bruto;
  final double? netto;

  PibkHargaResponseModel({
    this.kdVal,
    this.urKdVal,
    this.ndpbm,
    this.cif,
    this.asuransi,
    this.freight,
    this.cifRp,
    this.bruto,
    this.netto,
  });

  bool get isEmpty {
    return kdVal == null &&
        ndpbm == null &&
        cif == null &&
        cifRp == null;
  }

  factory PibkHargaResponseModel.fromJson(Map<String, dynamic> json) {
    final header = json['HEADER'];

    if (header == null) {
      return PibkHargaResponseModel();
    }

    return PibkHargaResponseModel(
      kdVal: header['KDVAL'],
      urKdVal: header['URKDVAL'],
      ndpbm: (header['NDPBM'] as num?)?.toDouble(),
      cif: (header['CIF'] as num?)?.toDouble(),
      asuransi: (header['ASURANSI'] as num?)?.toDouble(),
      freight: (header['FREIGHT'] as num?)?.toDouble(),
      cifRp: (header['CIFRP'] as num?)?.toDouble(),
      bruto: (header['BRUTO'] as num?)?.toDouble(),
      netto: (header['NETTO'] as num?)?.toDouble(),
    );
  }
}