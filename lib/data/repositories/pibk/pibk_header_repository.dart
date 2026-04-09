import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_header_response_model.dart';

class PibkHeaderRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibkHeaderResponseModel?> fetchPibkHeader(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/header/header',
      {
        // "USER_ID": userId,
        "USER_ID": 175, // bisa ganti userId
        "CAR": car,
      },
    );

    if (response == null) return null;

    return PibkHeaderResponseModel.fromJson(response);
  }
}