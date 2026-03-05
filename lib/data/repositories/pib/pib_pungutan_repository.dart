import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_pungutan_response_model.dart';

class PibPungutanRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibPungutanResponseModel?> fetchPungutan(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc20/header/pungutan',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response == null) return null;

    return PibPungutanResponseModel.fromJson(response);
  }
}