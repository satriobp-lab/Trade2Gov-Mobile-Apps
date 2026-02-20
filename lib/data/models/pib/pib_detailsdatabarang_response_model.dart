class PibDetailsDataBarangResponseModel {
  final int serial;
  final String car;
  final String noHs;
  final String brgUrai;
  final String merk;
  final String tipe;
  final String? spfLain;

  final String brgAsal;
  final String negaraAsal;

  final num cif;
  final num nilaiInvoice;
  final num biayaTambahan;
  final num diskon;

  final num jmlSat;
  final String kodeSatuan;
  final String kodeSatuanUr;

  final num jmlKemasan;
  final String kodeKemasan;
  final String kodeKemasanUr;

  final num netto;

  final num hargaSatuan;
  final num hargaFob;
  final num freight;
  final num asuransi;
  final num cifRp;

  // TARIF
  final num trpBm;
  final num trpBmIM;
  final num trpBmAD;
  final num trpBmPB;
  final num trpBmTP;
  final num trpCukai;
  final num trpPpn;
  final num trpPpnBm;
  final num trpPph;

  // FASILITAS
  final num fasBm;
  final num fasBmIM;
  final num fasBmAD;
  final num fasBmPB;
  final num fasBmTP;
  final num fasCuk;
  final num fasPpn;
  final num fasPbm;
  final num fasPph;

  PibDetailsDataBarangResponseModel({
    required this.serial,
    required this.car,
    required this.noHs,
    required this.brgUrai,
    required this.merk,
    required this.tipe,
    required this.spfLain,
    required this.brgAsal,
    required this.negaraAsal,
    required this.cif,
    required this.nilaiInvoice,
    required this.biayaTambahan,
    required this.diskon,
    required this.jmlSat,
    required this.kodeSatuan,
    required this.kodeSatuanUr,
    required this.jmlKemasan,
    required this.kodeKemasan,
    required this.kodeKemasanUr,
    required this.netto,
    required this.trpBm,
    required this.trpBmIM,
    required this.trpBmAD,
    required this.trpBmPB,
    required this.trpBmTP,
    required this.trpCukai,
    required this.trpPpn,
    required this.trpPpnBm,
    required this.trpPph,
    required this.fasBm,
    required this.fasBmIM,
    required this.fasBmAD,
    required this.fasBmPB,
    required this.fasBmTP,
    required this.fasCuk,
    required this.fasPpn,
    required this.fasPbm,
    required this.fasPph,
    required this.hargaSatuan,
    required this.hargaFob,
    required this.freight,
    required this.asuransi,
    required this.cifRp,
  });

  factory PibDetailsDataBarangResponseModel.fromJson(
      Map<String, dynamic> json) {

    final detil = json['DETIL'];

    return PibDetailsDataBarangResponseModel(
      serial: detil['SERIAL'] ?? 0,
      car: detil['CAR'] ?? '',
      noHs: detil['NOHS'] ?? '',
      brgUrai: detil['BRGURAI'] ?? '',
      merk: detil['MERK'] ?? '',
      tipe: (detil['TIPE'] ?? '').toString().trim(),
      spfLain: detil['SPFLAIN'],
      brgAsal: detil['BRGASAL'] ?? '',
      negaraAsal: detil['NEGARA_ASALUR'] ?? '',
      cif: detil['DCIF'] ?? 0,
      nilaiInvoice: detil['DNILINV'] ?? 0,
      biayaTambahan: detil['HBTAMBAHAN'] ?? 0,
      diskon: detil['HDISKON'] ?? 0,
      jmlSat: detil['JMLSAT'] ?? 0,
      kodeSatuan: detil['KDSAT'] ?? '',
      kodeSatuanUr: detil['KODE_SATUANUR'] ?? '',
      jmlKemasan: detil['KEMASJM'] ?? 0,
      kodeKemasan: detil['KEMASJN'] ?? '',
      kodeKemasanUr: detil['KODE_KEMASANUR'] ?? '',
      netto: detil['NETTODTL'] ?? 0,
      trpBm: detil['TRPBM'] ?? 0,
      trpBmIM: detil['TrpBmIM'] ?? 0,
      trpBmAD: detil['TrpBmAD'] ?? 0,
      trpBmPB: detil['TrpBmPB'] ?? 0,
      trpBmTP: detil['TrpBmTP'] ?? 0,
      trpCukai: detil['TRPCUK'] ?? 0,
      trpPpn: detil['TRPPPN'] ?? 0,
      trpPpnBm: detil['TRPPBM'] ?? 0,
      trpPph: detil['TRPPPH'] ?? 0,
      fasBm: detil['FASBM'] ?? 0,
      fasBmIM: detil['FasBMIM'] ?? 0,
      fasBmAD: detil['FasBMAD'] ?? 0,
      fasBmPB: detil['FasBMPB'] ?? 0,
      fasBmTP: detil['FasBMTP'] ?? 0,
      fasCuk: detil['FASCUK'] ?? 0,
      fasPpn: detil['FASPPN'] ?? 0,
      fasPbm: detil['FASPBM'] ?? 0,
      hargaSatuan: detil['HARGA_SATUAN'] ?? 0,
      hargaFob: detil['HARGAFOB'] ?? 0,
      freight: detil['HFREIGHT'] ?? 0,
      asuransi: detil['HASURANSI'] ?? 0,
      cifRp: detil['HINVOICE'] ?? 0,
      fasPph: detil['FASPPH'] ?? 0,
    );
  }
}