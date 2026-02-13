class EdecResponseModel {
  final int pib;
  final int pibk;
  final int peb;
  final int pkbe;
  final String tahun;

  final List<String> pibList;
  final List<String> pebList;

  EdecResponseModel({
    required this.pib,
    required this.pibk,
    required this.peb,
    required this.pkbe,
    required this.tahun,
    required this.pibList,
    required this.pebList,
  });

  factory EdecResponseModel.fromJson(Map<String, dynamic> json) {
    return EdecResponseModel(
      pib: json['pib'] ?? 0,
      pibk: json['pibk'] ?? 0,
      peb: json['peb'] ?? 0,
      pkbe: json['pkbe'] ?? 0,
      tahun: json['tahun'] ?? '',
      pibList: json['piblist'] != null
          ? List<String>.from(json['piblist'])
          : [],
      pebList: json['peblist'] != null
          ? List<String>.from(json['peblist'])
          : [],
    );
  }
}
