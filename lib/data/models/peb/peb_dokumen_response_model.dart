class PebDokumenResponseModel {
  final String? kdDok;
  final String? jnsDok;
  final String? noDok;
  final String? tanggal;
  final String? car;

  PebDokumenResponseModel({
    this.kdDok,
    this.jnsDok,
    this.noDok,
    this.tanggal,
    this.car,
  });

  factory PebDokumenResponseModel.fromJson(Map<String, dynamic> json) {
    return PebDokumenResponseModel(
      kdDok: json['KDDOK'],
      jnsDok: json['JNSDOK'],
      noDok: json['NODOK'],
      tanggal: json['Tanggal'],
      car: json['CAR'],
    );
  }
}