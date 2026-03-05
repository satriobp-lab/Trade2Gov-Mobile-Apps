class PibPungutanItem {
  final List<dynamic>? values;

  PibPungutanItem({this.values});

  factory PibPungutanItem.fromJson(dynamic json) {
    if (json is List) {
      return PibPungutanItem(values: json);
    }
    return PibPungutanItem(values: []);
  }

  Map<String, String> toUiMap() {
    String formatValue(dynamic value) {
      if (value == null || value == 0) return '-';
      return _formatNumber(value);
    }

    return {
      'Dibayar': formatValue(values?[0]),
      'Ditanggung Pemerintah': formatValue(values?[1]),
      'Ditunda': formatValue(values?[2]),
      'Tidak Dipungut': formatValue(values?[3]),
      'Dibebaskan': formatValue(values?[4]),
      'Telah Dilunasi': formatValue(values?[5]),
    };
  }

  static String _formatNumber(dynamic number) {
    final value = number.toString();
    final buffer = StringBuffer();
    int counter = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      buffer.write(value[i]);
      counter++;
      if (counter == 3 && i != 0) {
        buffer.write('.');
        counter = 0;
      }
    }

    return buffer.toString().split('').reversed.join();
  }
}

class PibPungutanResponseModel {
  final Map<String, PibPungutanItem> data;

  PibPungutanResponseModel({required this.data});

  factory PibPungutanResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, PibPungutanItem> mappedData = {};

    json.forEach((key, value) {
      mappedData[key] = PibPungutanItem.fromJson(value);
    });

    return PibPungutanResponseModel(data: mappedData);
  }

  PibPungutanItem? getByCode(String code) {
    return data[code];
  }
}