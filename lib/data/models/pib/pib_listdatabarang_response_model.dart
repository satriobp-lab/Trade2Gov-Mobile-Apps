class PibListDataBarangResponseModel {
  final int serial;
  final String brgUrai;
  final String noHs;
  final String kodeHs;
  final num dNilInv;
  final int kemasJm;
  final String kemasJn;
  final String jnsKemasan;
  final num nettoDtl;
  final String status;
  final String car;

  PibListDataBarangResponseModel({
    required this.serial,
    required this.brgUrai,
    required this.noHs,
    required this.kodeHs,
    required this.dNilInv,
    required this.kemasJm,
    required this.kemasJn,
    required this.jnsKemasan,
    required this.nettoDtl,
    required this.status,
    required this.car,
  });

  factory PibListDataBarangResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PibListDataBarangResponseModel(
      serial: json['SERIAL'] ?? 0,
      brgUrai: json['BRGURAI'] ?? '',
      noHs: json['NOHS'] ?? '',
      kodeHs: json['KODEHS'] ?? '',
      dNilInv: json['DNILINV'] ?? 0,
      kemasJm: json['KEMASJM'] ?? 0,
      kemasJn: json['KEMASJN'] ?? '',
      jnsKemasan: json['JNSKEMASAN'] ?? '',
      nettoDtl: json['NETTODTL'] ?? 0,
      status: json['STATUS'] ?? '',
      car: json['CAR'] ?? '',
    );
  }
}