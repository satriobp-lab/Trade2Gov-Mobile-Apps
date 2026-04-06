class PibHistoryListResponseModel {
  final String noAju;
  final String? tglAju;
  final String? pibNo;
  final String? pibTg;
  final String? kdKpbc;
  final String? urKpbc;
  final String? indNama;
  final int jmBrg;
  final int jmCont;
  final String? car;

  PibHistoryListResponseModel({
    required this.noAju,
    required this.tglAju,
    this.pibNo,
    this.pibTg,
    required this.kdKpbc,
    required this.urKpbc,
    required this.indNama,
    required this.jmBrg,
    required this.jmCont,
    this.car,
  });

  factory PibHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return PibHistoryListResponseModel(
      noAju: json['NOAJU'] ?? '',
      tglAju: json['TGLAJU'],
      pibNo: json['PIBNO'],
      pibTg: json['PIBTG'],
      kdKpbc: json['KDKPBC'],
      urKpbc: json['URKPBC'],
      indNama: json['INDNAMA'],
      jmBrg: json['JMBRG'] ?? 0,
      jmCont: json['JMCONT'] ?? 0,
      car: json['CAR'],
    );
  }
}
