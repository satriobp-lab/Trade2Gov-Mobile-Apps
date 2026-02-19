class PibHeaderResponseModel {
  final String tipeTrader;
  final HeaderData header;

  final Map<String, dynamic> jnPibMap;
  final Map<String, dynamic> jnImpMap;
  final Map<String, dynamic> crByrMap;
  final Map<String, dynamic> modaMap;
  final Map<String, dynamic> apiKdMap;

  PibHeaderResponseModel({
    required this.tipeTrader,
    required this.header,
    required this.jnPibMap,
    required this.jnImpMap,
    required this.crByrMap,
    required this.modaMap,
    required this.apiKdMap,
  });

  factory PibHeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return PibHeaderResponseModel(
      tipeTrader: json['TIPE_TRADER'] ?? '',
      header: HeaderData.fromJson(json['HEADER'] ?? {}),
      jnPibMap: Map<String, dynamic>.from(json['JNPIB'] ?? {}),
      jnImpMap: Map<String, dynamic>.from(json['JNIMP'] ?? {}),
      crByrMap: Map<String, dynamic>.from(json['CRBYR'] ?? {}),
      modaMap: Map<String, dynamic>.from(json['MODA'] ?? {}),
      apiKdMap: Map<String, dynamic>.from(json['APIKD'] ?? {}),
    );
  }
}

class HeaderData {
  final String car;
  final String kdKpbc;
  final String urKpbc;
  final String jnPib;
  final String jnImp;
  final String crByr;

  final String impNama;
  final String impAlmt;
  final String impNpwp;

  final String pasokNama;
  final String pasokAlmt;
  final String pasokNeg; // ✅ TAMBAH
  final String urPasokNeg;

  final String penjNama;
  final String penjAlmt;
  final String penjNeg;

  final String apiKd; // ✅ TAMBAH
  final String apiNo; // ✅ TAMBAH

  final String moda;
  final String angkutNama;
  final String angkutNo;
  final String urAngkutFl;
  final String tgtiba;
  final String pelMuatUr;
  final String pelBkrUr;

  final String ppjkNpwp;
  final String ppjkNama;
  final String ppjkAlmt;
  final String ppjkNo;
  final String ppjkTg;

  final String impStatus;
  final String pelTransitUr;
  final String urKdFas;
  final String urTmptBn;



  HeaderData({
    required this.car,
    required this.kdKpbc,
    required this.urKpbc,
    required this.jnPib,
    required this.jnImp,
    required this.crByr,
    required this.impNama,
    required this.impAlmt,
    required this.impNpwp,
    required this.pasokNama,
    required this.pasokAlmt,
    required this.pasokNeg,   // ✅ TAMBAH
    required this.urPasokNeg,
    required this.penjNama,
    required this.penjAlmt,
    required this.penjNeg,
    required this.apiKd,      // ✅ TAMBAH
    required this.apiNo,      // ✅ TAMBAH
    required this.moda,
    required this.angkutNama,
    required this.angkutNo,
    required this.urAngkutFl,
    required this.tgtiba,
    required this.pelMuatUr,
    required this.pelBkrUr,
    required this.ppjkNpwp,
    required this.ppjkNama,
    required this.ppjkAlmt,
    required this.ppjkNo,
    required this.ppjkTg,
    required this.impStatus,
    required this.pelTransitUr,
    required this.urKdFas,
    required this.urTmptBn,



  });

  factory HeaderData.fromJson(Map<String, dynamic> json) {
    return HeaderData(
      car: json['CAR'] ?? '',
      kdKpbc: json['KDKPBC'] ?? '',
      urKpbc: json['URAIAN_KPBC'] ?? '',
      jnPib: json['JNPIB'] ?? '',
      jnImp: json['JNIMP'] ?? '',
      crByr: json['CRBYR'] ?? '',
      impNama: json['IMPNAMA'] ?? '',
      impAlmt: json['IMPALMT'] ?? '',
      impNpwp: json['IMPNPWP'] ?? '',
      pasokNama: json['PASOKNAMA'] ?? '',
      pasokAlmt: json['PASOKALMT'] ?? '',
      pasokNeg: json['PASOKNEG'] ?? '', // ✅ TAMBAH
      urPasokNeg: json['URPASOKNEG'] ?? '',
      penjNama: json['PENJNAMA'] ?? '',
      penjAlmt: json['PENJALMT'] ?? '',
      penjNeg: json['PENJNEG'] ?? '',
      apiKd: json['APIKD'] ?? '',       // ✅ TAMBAH
      apiNo: json['APINO'] ?? '',       // ✅ TAMBAH
      moda: json['MODA'] ?? '',
      angkutNama: json['ANGKUTNAMA'] ?? '',
      angkutNo: json['ANGKUTNO'] ?? '',
      urAngkutFl: json['URANGKUTFL'] ?? '',
      tgtiba: json['TGTIBA'] ?? '',
      pelMuatUr: json['PELMUATUR'] ?? '',
      pelBkrUr: json['PELBKRUR'] ?? '',
      ppjkNpwp: json['PPJKNPWP'] ?? '',
      ppjkNama: json['PPJKNAMA'] ?? '',
      ppjkAlmt: json['PPJKALMT'] ?? '',
      ppjkNo: json['PPJKNO'] ?? '',
      ppjkTg: json['PPJKTG'] ?? '',
      impStatus: json['IMPSTATUS']?.toString() ?? '',
      pelTransitUr: json['PELTRANSITUR']?.toString() ?? '',
      urKdFas: json['URKDFAS']?.toString() ?? '',
      urTmptBn: json['URTMPTBN']?.toString() ?? '',



    );
  }
}

