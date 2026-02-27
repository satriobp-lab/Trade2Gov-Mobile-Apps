class PibkHistoryListResponseModel {
  final String dateCol;
  final String car;
  final String? tanggal;
  final String? kdKpbc;
  final String? urKpbc;
  final String? pasokNama;
  final String? impNama;
  final int jmBrg;
  final String? status;

  PibkHistoryListResponseModel({
    required this.dateCol,
    required this.car,
    this.tanggal,
    this.kdKpbc,
    this.urKpbc,
    this.pasokNama,
    this.impNama,
    required this.jmBrg,
    this.status,
  });

  factory PibkHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return PibkHistoryListResponseModel(
      dateCol: json['DATECOL'] ?? '',
      car: json['CAR'] ?? '',
      tanggal: json['Tanggal'],
      kdKpbc: json['KDKPBC'],
      urKpbc: json['URKPBC'],
      pasokNama: json['PASOKNAMA'],
      impNama: json['IMPNAMA'],
      jmBrg: json['JMBRG'] ?? 0,
      status: json['STATUS'],
    );
  }
}