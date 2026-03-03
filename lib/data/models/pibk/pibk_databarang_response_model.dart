class PibkDataBarangResponseModel {
  final Map<String, dynamic> detil;

  PibkDataBarangResponseModel({
    required this.detil,
  });

  factory PibkDataBarangResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PibkDataBarangResponseModel(
      detil: json['DETIL'] ?? {},
    );
  }

  dynamic getValue(String key) {
    return detil[key];
  }
}