class PebListDataBarangResponseModel {
  final String? car;
  final int? seriBrg;
  final String? hs;
  final String? kodeHs;
  final String? uraianBarang;
  final String? merk;
  final String? size;
  final String? type;
  final String? kodeBarang;
  final String? nilaiInvoice;
  final String? jumlahSatuan;
  final String? jenisSatuan;
  final String? neto;
  final String? status;

  PebListDataBarangResponseModel({
    this.car,
    this.seriBrg,
    this.hs,
    this.kodeHs,
    this.uraianBarang,
    this.merk,
    this.size,
    this.type,
    this.kodeBarang,
    this.nilaiInvoice,
    this.jumlahSatuan,
    this.jenisSatuan,
    this.neto,
    this.status,
  });

  factory PebListDataBarangResponseModel.fromJson(Map<String, dynamic> json) {
    return PebListDataBarangResponseModel(
      car: json['CAR'],
      seriBrg: json['SERIBRG'],
      hs: json['HS'],
      kodeHs: json['KODEHS'],
      uraianBarang: json['URBRG1'],
      merk: json['DMERK'],
      size: json['SIZE'],
      type: json['TYPE'],
      kodeBarang: json['KDBRG'],
      nilaiInvoice: json['DNILINV'],
      jumlahSatuan: json['JMSATUAN'],
      jenisSatuan: json['JNSATUAN'],
      neto: json['NETDET'],
      status: json['STATUS'],
    );
  }
}