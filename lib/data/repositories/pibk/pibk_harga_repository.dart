import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_harga_response_model.dart';

class PibkHargaRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibkHargaResponseModel?> fetchPibkHarga(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/header/header',
      {
        "USER_ID": userId,
        // "USER_ID": 175,
        "CAR": car,
      },
    );

    if (response == null) {
      return null;
    }

    return PibkHargaResponseModel.fromJson(response);
  }
}