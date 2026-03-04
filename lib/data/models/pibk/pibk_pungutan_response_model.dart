class PibkPungutanResponseModel {
  final int total;
  final Map<String, int> pungutanMap;

  PibkPungutanResponseModel({
    required this.total,
    required this.pungutanMap,
  });

  factory PibkPungutanResponseModel.fromJson(Map<String, dynamic> json) {
    Map<String, int> map = {};

    json.forEach((key, value) {
      if (key != 'TOTAL') {
        map[key] = value ?? 0;
      }
    });

    return PibkPungutanResponseModel(
      total: json['TOTAL'] ?? 0,
      pungutanMap: map,
    );
  }
}