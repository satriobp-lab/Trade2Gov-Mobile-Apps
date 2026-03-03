import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_databarang_response_model.dart';

class PibkDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibkDataBarangResponseModel?> fetchDataBarangDetail({
    required String car,
    required int serial,
  }) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/detail/barang',
      {
        // "USER_ID": userId,
        "USER_ID": 175,
        "CAR": car,
        "SERIAL": serial,
      },
    );

    if (response == null) return null;

    if (response is Map<String, dynamic>) {
      return PibkDataBarangResponseModel.fromJson(response);
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}