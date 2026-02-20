import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_detailsdatabarang_response_model.dart';

class PibDetailsDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibDetailsDataBarangResponseModel> fetchDetails({
    required String car,
    required String serial,
  }) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc20/detail/barang',
      {
        "USER_ID": userId,
        "CAR": car,
        "SERIAL": serial,
      },
    );

    return PibDetailsDataBarangResponseModel.fromJson(response);
  }
}