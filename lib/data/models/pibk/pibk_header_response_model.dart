class PibkHeaderResponseModel {
  final Map<String, dynamic> header;
  final Map<String, dynamic> jnsAju;
  final Map<String, dynamic> jnsPibk;
  final Map<String, dynamic> jnPib;
  final Map<String, dynamic> jnImp;
  final Map<String, dynamic> crByr;
  final List<dynamic> impId;
  final Map<String, dynamic> moda;
  final Map<String, dynamic> dokTupKd;

  PibkHeaderResponseModel({
    required this.header,
    required this.jnsAju,
    required this.jnsPibk,
    required this.jnPib,
    required this.jnImp,
    required this.crByr,
    required this.impId,
    required this.moda,
    required this.dokTupKd,
  });

  factory PibkHeaderResponseModel.fromJson(Map<String, dynamic> json) {
    return PibkHeaderResponseModel(
      header: json['HEADER'] ?? {},
      jnsAju: json['JNSAJU'] ?? {},
      jnsPibk: json['JNSPIBK'] ?? {},
      jnPib: json['JNPIB'] ?? {},
      jnImp: json['JNIMP'] ?? {},
      crByr: json['CRBYR'] ?? {},
      impId: json['IMPID'] ?? [],
      moda: json['MODA'] ?? {},
      dokTupKd: json['DOKTUPKD'] ?? {},
    );
  }
}