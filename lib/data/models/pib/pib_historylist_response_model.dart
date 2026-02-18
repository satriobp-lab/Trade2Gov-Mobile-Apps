class PibHistoryListResponseModel {
  final String noAju;
  final String? tglAju;
  final String? pibNo;      // ✅ Nomor Daftar
  final String? pibTg;      // ✅ Tanggal Daftar
  final String? kdKpbc;
  final String? urKpbc;
  final String? indNama;
  final int jmBrg;
  final int jmCont;

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
  });

  factory PibHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return PibHistoryListResponseModel(
      noAju: json['NOAJU'] ?? '',
      tglAju: json['TGLAJU'],
      pibNo: json['PIBNO'],      // ✅ mapping
      pibTg: json['PIBTG'],      // ✅ mapping
      kdKpbc: json['KDKPBC'],
      urKpbc: json['URKPBC'],
      indNama: json['INDNAMA'],
      jmBrg: json['JMBRG'] ?? 0,
      jmCont: json['JMCONT'] ?? 0,
    );
  }
}
