import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_kemasan_response_model.dart';

class PebKemasanRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PebKemasanResponseModel>> fetchKemasan({
    required String car,
  }) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/kemasan',
      {
        // "USER_ID": userId,
        "USER_ID": 175,
        "CAR": car,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PebKemasanResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}