class PebTransaksiEksporResponseModel {
  final String? kdBank;
  final String? lokBank;

  final String? kdVal;
  final String? urKdVal;

  final double fob;
  final double freight;
  final double asuransi;
  final String? kdAss;
  final double nilMaklon;

  PebTransaksiEksporResponseModel({
    this.kdBank,
    this.lokBank,
    this.kdVal,
    this.urKdVal,
    required this.fob,
    required this.freight,
    required this.asuransi,
    this.kdAss,
    required this.nilMaklon,
  });

  factory PebTransaksiEksporResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PebTransaksiEksporResponseModel(
      kdBank: json['KDBANK'],
      lokBank: json['LOKBANK'],
      kdVal: json['KDVAL'],
      urKdVal: json['URKDVAL'],
      fob: (json['FOB'] ?? 0).toDouble(),
      freight: (json['FREIGHT'] ?? 0).toDouble(),
      asuransi: (json['ASURANSI'] ?? 0).toDouble(),
      kdAss: json['KDASS'],
      nilMaklon: (json['NILMAKLON'] ?? 0).toDouble(),
    );
  }
}