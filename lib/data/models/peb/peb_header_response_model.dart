class PebHeaderResponseModel {
  // ===== DATA PEB =====
  final String? car;
  final String? kdKtr;
  final String? urKdKtr;
  final String? kdKtrEks;
  final String? urKdKtrEks;
  final String? noDaft;
  final String? tgDaft;

  final String? jneks;
  final String? kateks;
  final String? jndag;
  final String? jnbyr;

  // ===== EKSPORTIR =====
  final String? npwpEks;
  final String? namaEks;
  final String? alamatEks;
  final String? statusH;
  final String? niper;

  // ===== PEMBELI =====
  final String? namaBeli;
  final String? alamatBeli;
  final String? negBeli;
  final String? urNegBeli;

  final String? namaBeli2;
  final String? alamatBeli2;
  final String? negBeli2;
  final String? urNegBeli2;

  // ===== PPJK =====
  final String? npwpPpjk;
  final String? namaPpjk;
  final String? alamatPpjk;

  // ===== PENGANGKUTAN =====
  final String? moda;
  final String? tgEks;
  final String? carrier;
  final String? voy;
  final String? bendera;
  final String? urBendera;

  final String? pelMuat;
  final String? urPelMuat;

  final String? pelMuatEks;
  final String? urPelMuatEks;

  final String? pelBongkar;
  final String? urPelBongkar;

  final String? pelTujuan;
  final String? urPelTujuan;

  final String? negTuju;
  final String? urNegTuju;

  final String? kdLokBrg;
  final String? kdKtrPriks;
  final String? urKdKtrPriks;

  final String? gudangPlb;

  final String? delivery;
  final String? kmdt;

  final double? volume;
  final double? bruto;
  final double? netto;

  final int? jumlahBarang;
  final double? nilKurs;
  final double? nilPe;
  final double? nilPajakLain;

  final String? urJneks;
  final String? urKateks;
  final String? urJndag;
  final String? urJnbyr;

  final String? urStatusH;
  final String? urModa;
  final String? urKmdt;

  PebHeaderResponseModel({
    this.car,
    this.kdKtr,
    this.urKdKtr,
    this.kdKtrEks,
    this.urKdKtrEks,
    this.noDaft,
    this.tgDaft,
    this.jneks,
    this.kateks,
    this.jndag,
    this.jnbyr,
    this.npwpEks,
    this.namaEks,
    this.alamatEks,
    this.statusH,
    this.niper,
    this.namaBeli,
    this.alamatBeli,
    this.negBeli,
    this.urNegBeli,
    this.namaBeli2,
    this.alamatBeli2,
    this.negBeli2,
    this.urNegBeli2,
    this.npwpPpjk,
    this.namaPpjk,
    this.alamatPpjk,
    this.moda,
    this.tgEks,
    this.carrier,
    this.voy,
    this.bendera,
    this.urBendera,
    this.pelMuat,
    this.urPelMuat,
    this.pelMuatEks,
    this.urPelMuatEks,
    this.pelBongkar,
    this.urPelBongkar,
    this.pelTujuan,
    this.urPelTujuan,
    this.negTuju,
    this.urNegTuju,
    this.kdLokBrg,
    this.kdKtrPriks,
    this.urKdKtrPriks,
    this.gudangPlb,
    this.delivery,
    this.kmdt,
    this.volume,
    this.bruto,
    this.netto,
    this.jumlahBarang,
    this.nilKurs,
    this.nilPe,
    this.nilPajakLain,

    this.urJneks,
    this.urKateks,
    this.urJndag,
    this.urJnbyr,

    this.urStatusH,
    this.urModa,
    this.urKmdt,
  });

  factory PebHeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return PebHeaderResponseModel(
      car: json['CAR'],
      kdKtr: json['KDKTR'],
      urKdKtr: json['URKDKTR'],
      kdKtrEks: json['KDKTREKS'],
      urKdKtrEks: json['URKDKTREKS'],
      noDaft: json['NODAFT'],
      tgDaft: json['TGDAFT'],
      jneks: json['JNEKS'],
      kateks: json['KATEKS'],
      jndag: json['JNDAG'],
      jnbyr: json['JNBYR'],
      npwpEks: json['NPWPEKS'],
      namaEks: json['NAMAEKS'],
      alamatEks: json['ALMTEKS'],
      statusH: json['STATUSH'],
      niper: json['NIPER'],
      namaBeli: json['NAMABELI'],
      alamatBeli: json['ALMTBELI'],
      negBeli: json['NEGBELI'],
      urNegBeli: json['URNEGBELI'],
      namaBeli2: json['NAMABELI2'],
      alamatBeli2: json['ALMTBELI2'],
      negBeli2: json['NEGBELI2'],
      urNegBeli2: json['URNEGBELI2'],
      npwpPpjk: json['NPWPPPJK'],
      namaPpjk: json['NAMAPPJK'],
      alamatPpjk: json['ALMTPPJK'],
      moda: json['MODA'],
      tgEks: json['TGEKS'],
      carrier: json['CARRIER'],
      voy: json['VOY'],
      bendera: json['BENDERA'],
      urBendera: json['URBENDERA'],
      pelMuat: json['PELMUAT'],
      urPelMuat: json['URPELMUAT'],
      pelMuatEks: json['PELMUATEKS'],
      urPelMuatEks: json['URPELMUATEKS'],
      pelBongkar: json['PELBONGKAR'],
      urPelBongkar: json['URPELBONGKAR'],
      pelTujuan: json['PELTUJUAN'],
      urPelTujuan: json['URPELTUJUAN'],
      negTuju: json['NEGTUJU'],
      urNegTuju: json['URNEGTUJU'],
      kdLokBrg: json['KDLOKBRG'],
      kdKtrPriks: json['KDKTRPRIKS'],
      urKdKtrPriks: json['URKDKTRPRIKS'],
      gudangPlb: json['GUDANGPLB'],
      delivery: json['DELIVERY'],
      kmdt: json['KMDT'],
      volume: (json['VOLUME'] as num?)?.toDouble(),
      bruto: (json['BRUTO'] as num?)?.toDouble(),
      netto: (json['NETTO'] as num?)?.toDouble(),
      jumlahBarang: json['JUMLAHBARANG'],
      nilKurs: (json['NILKURS'] as num?)?.toDouble(),
      nilPe: (json['NILPE'] as num?)?.toDouble(),
      nilPajakLain: (json['NILPAJAKLAIN'] as num?)?.toDouble(),
    );
  }
}