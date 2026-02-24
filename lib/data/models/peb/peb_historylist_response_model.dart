class PebHistoryListResponseModel {
  final String noAju;
  final String? tglAju;
  final String? tglDaft;
  final String? noDaft;
  final String? car;
  final String? kdKtr;
  final String? urKtr;
  final String? uraian;
  final String? namaEks;
  final String? namaBeli;
  final String? carrier;
  final int jmBrg;
  final int jmCont;
  final String? status;

  PebHistoryListResponseModel({
    required this.noAju,
    this.tglAju,
    this.tglDaft,
    this.noDaft,
    this.car,
    this.kdKtr,
    this.urKtr,
    this.uraian,
    this.namaEks,
    this.namaBeli,
    this.carrier,
    required this.jmBrg,
    required this.jmCont,
    this.status,
  });

  factory PebHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return PebHistoryListResponseModel(
      noAju: json['NOAJU'] ?? '',
      tglAju: json['TGLAJU'],
      tglDaft: json['TGDAFT'],
      noDaft: json['NODAFT'],
      car: json['CAR'],
      kdKtr: json['KDKTR'],
      urKtr: json['URKDKTR'],
      uraian: json['URAIAN'],
      namaEks: json['NAMAEKS'],
      namaBeli: json['NAMABELI'],
      carrier: json['CARRIER'],
      jmBrg: json['round(a.JMBRG)'] ?? 0,
      jmCont: json['round(a.JMCONT)'] ?? 0,
      status: json['STATUS'],
    );
  }
}