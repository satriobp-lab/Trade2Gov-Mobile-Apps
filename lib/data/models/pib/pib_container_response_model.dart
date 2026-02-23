class PibContainerResponseModel {
  final String? nomor;
  final String? seri;
  final String? ukuran;
  final String? tipe;
  final String? car;

  PibContainerResponseModel({
    this.nomor,
    this.seri,
    this.ukuran,
    this.tipe,
    this.car,
  });

  factory PibContainerResponseModel.fromJson(Map<String, dynamic> json) {
    return PibContainerResponseModel(
      nomor: json['Nomor'],
      seri: json['SERI'],
      ukuran: json['Ukuran'],
      tipe: json['Tipe'],
      car: json['CAR'],
    );
  }

  /// Null-safe display
  String get nomorDisplay =>
      (nomor == null || nomor!.trim().isEmpty) ? '-' : nomor!;

  String get seriDisplay =>
      (seri == null || seri!.trim().isEmpty) ? '-' : seri!;

  String get ukuranDisplay =>
      (ukuran == null || ukuran!.trim().isEmpty) ? '-' : ukuran!;

  String get tipeDisplay =>
      (tipe == null || tipe!.trim().isEmpty) ? '-' : tipe!;
}