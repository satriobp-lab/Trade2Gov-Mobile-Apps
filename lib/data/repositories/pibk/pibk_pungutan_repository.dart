import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_pungutan_response_model.dart';

class PibkPungutanRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibkPungutanResponseModel?> fetchPungutan(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/header/pungutan',
      {
        // "USER_ID": userId,
        "USER_ID": 175,
        "CAR": car,
      },
    );

    if (response == null) {
      return null;
    }

    if (response is List) {
      if (response.isEmpty) {
        return null;
      }
    }

    if (response is Map<String, dynamic>) {
      return PibkPungutanResponseModel.fromJson(response);
    }

    return null;
  }
}