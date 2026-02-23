import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_kemasan_response_model.dart';

class PibKemasanRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibKemasanResponseModel>> fetchKemasan(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc20/header/kemasan',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response is List) {
      return response
          .map((e) => PibKemasanResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}