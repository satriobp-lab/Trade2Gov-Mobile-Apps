class PebDetailsDataBarangResponseModel {
  final int? seriBrg;
  final String? hs;
  final String? uraianBarang;
  final String? merk;
  final String? type;
  final String? size;
  final String? kodeBarang;

  final int? jumlahKoli;
  final String? jenisKoli;
  final String? uraianJenisKoli;
  final double? netto;
  final double? volume;
  final String? negaraAsal;
  final String? uraianNegaraAsal;
  final String? daerahAsal;
  final String? uraianDaerahAsal;

  final dynamic fob;
  final dynamic jumlahSatuan;
  final String? jenisSatuan;
  final String? uraianJenisSatuan;

  final String? kdIzin;
  final String? noIzin;
  final String? tglIzin;

  final dynamic tarifPe;

  PebDetailsDataBarangResponseModel({
    this.seriBrg,
    this.hs,
    this.uraianBarang,
    this.merk,
    this.type,
    this.size,
    this.kodeBarang,
    this.jumlahKoli,
    this.jenisKoli,
    this.uraianJenisKoli,
    this.netto,
    this.volume,
    this.negaraAsal,
    this.uraianNegaraAsal,
    this.daerahAsal,
    this.uraianDaerahAsal,
    this.fob,
    this.jumlahSatuan,
    this.jenisSatuan,
    this.uraianJenisSatuan,
    this.kdIzin,
    this.noIzin,
    this.tglIzin,
    this.tarifPe,
  });

  factory PebDetailsDataBarangResponseModel.fromJson(
      Map<String, dynamic> json) {
    final detil = json['DETIL'];

    return PebDetailsDataBarangResponseModel(
      seriBrg: detil['SERIBRG'],
      hs: detil['HS'],
      uraianBarang: [
        detil['URBRG1'],
        detil['URBRG2'],
        detil['URBRG3'],
        detil['URBRG4']
      ].where((e) => e != null && e.toString().isNotEmpty).join(' '),
      merk: detil['DMERK'],
      type: detil['TYPE'],
      size: detil['SIZE'],
      kodeBarang: detil['KDBRG'],
      jumlahKoli: detil['JMKOLI'],
      jenisKoli: detil['JNKOLI'],
      uraianJenisKoli: detil['URJNKOLI'],
      netto: (detil['NETDET'] as num?)?.toDouble(),
      volume: (detil['DVOLUME'] as num?)?.toDouble(),
      negaraAsal: detil['NEGASAL'],
      uraianNegaraAsal: detil['URNEGASAL'],
      daerahAsal: detil['DRHASALBRG'],
      uraianDaerahAsal: detil['URDRHASALBRG'],
      fob: detil['FOBPERBRG'],
      jumlahSatuan: detil['JMSATUAN'],
      jenisSatuan: detil['JNSATUAN'],
      uraianJenisSatuan: detil['URJNSATUAN'],
      kdIzin: detil['KDIZIN'],
      noIzin: detil['NOIZIN'],
      tglIzin: detil['TGIZIN']?.toString(),
      tarifPe: detil['TARIPPE'],
    );
  }
}