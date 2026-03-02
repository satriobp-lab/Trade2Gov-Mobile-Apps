class PibkDokumenResponseModel {
  final String kode;
  final String jenis;
  final String nomor;
  final String tanggal;
  final String? perizinan;
  final String car;
  final String? seri;
  final int? dokId;
  final String? dokNo;
  final int? noUrut;

  PibkDokumenResponseModel({
    required this.kode,
    required this.jenis,
    required this.nomor,
    required this.tanggal,
    this.perizinan,
    required this.car,
    this.seri,
    this.dokId,
    this.dokNo,
    this.noUrut,
  });

  factory PibkDokumenResponseModel.fromJson(Map<String, dynamic> json) {
    return PibkDokumenResponseModel(
      kode: json['Kode'] ?? '',
      jenis: json['Jenis'] ?? '',
      nomor: json['Nomor'] ?? '',
      tanggal: json['Tanggal'] ?? '',
      perizinan: json['Perizinan'],
      car: json['CAR'] ?? '',
      seri: json['SERI'],
      dokId: json['DOKID'],
      dokNo: json['DOKNO'],
      noUrut: json['NoUrut'],
    );
  }
}