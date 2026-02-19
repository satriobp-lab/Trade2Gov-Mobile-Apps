class PibDokumenResponseModel {
  final String kode;
  final String jenis;
  final String nomor;
  final String tanggal;
  final String? perizinan;
  final String car;
  final String seri;
  final int dokId;
  final String dokNo;
  final int noUrut;

  PibDokumenResponseModel({
    required this.kode,
    required this.jenis,
    required this.nomor,
    required this.tanggal,
    this.perizinan,
    required this.car,
    required this.seri,
    required this.dokId,
    required this.dokNo,
    required this.noUrut,
  });

  factory PibDokumenResponseModel.fromJson(Map<String, dynamic> json) {
    return PibDokumenResponseModel(
      kode: json['Kode'] ?? '',
      jenis: json['Jenis'] ?? '',
      nomor: json['Nomor'] ?? '',
      tanggal: json['Tanggal'] ?? '',
      perizinan: json['Perizinan'],
      car: json['CAR'] ?? '',
      seri: json['SERI'] ?? '',
      dokId: json['DOKID'] ?? 0,
      dokNo: json['DOKNO'] ?? '',
      noUrut: json['NoUrut'] ?? 0,
    );
  }
}
