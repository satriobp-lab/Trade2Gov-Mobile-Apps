import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_transaksiekspor_response_model.dart';

class PebTransaksiEksporRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PebTransaksiEksporResponseModel?> fetchTransaksiEkspor({
    required String car,
  }) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/header',
      {
        "USER_ID": userId,
        // "USER_ID": 175, // 🔥 sementara force dulu
        "CAR": car,
      },
    );

    if (response == null) return null;

    if (response['HEADER'] != null) {
      return PebTransaksiEksporResponseModel.fromJson(
          response['HEADER']);
    }

    return null;
  }
}