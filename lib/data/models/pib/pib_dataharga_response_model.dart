class PibDataHargaResponseModel {
  final String valuta;
  final String urValuta;
  final num ndpbm;
  final num cif;
  final num asuransi;
  final num freight;
  final num cifRp;
  final num bruto;
  final num netto;

  PibDataHargaResponseModel({
    required this.valuta,
    required this.urValuta,
    required this.ndpbm,
    required this.cif,
    required this.asuransi,
    required this.freight,
    required this.cifRp,
    required this.bruto,
    required this.netto,
  });

  factory PibDataHargaResponseModel.fromJson(Map<String, dynamic> json) {
    final header = json['HEADER'] ?? {};

    return PibDataHargaResponseModel(
      valuta: header['KDVAL'] ?? '',
      urValuta: header['URKDVAL'] ?? '',
      ndpbm: header['NDPBM'] ?? 0,
      cif: header['CIF'] ?? 0,
      asuransi: header['ASURANSI'] ?? 0,
      freight: header['FREIGHT'] ?? 0,
      cifRp: header['CIFRP'] ?? 0,
      bruto: header['BRUTO'] ?? 0,
      netto: header['NETTO'] ?? 0,
    );
  }
}