import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_detailsdatabarang_response_model.dart';

class PebDetailsDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PebDetailsDataBarangResponseModel?> fetchDetails({
    required String car,
    required String seriBrg,
  }) async {
    final userId = await _storage.getUserId();

    if (userId == null) {
      throw Exception("User belum login");
    }

    final response = await _api.postRaw(
      'edeclaration/bc30/detail/barang',
      {
        "USER_ID": 175,
        "CAR": car,
        "SERIBRG": seriBrg,
      },
    );

    if (response == null) {
      return null;
    }

    return PebDetailsDataBarangResponseModel.fromJson(response);
  }
}