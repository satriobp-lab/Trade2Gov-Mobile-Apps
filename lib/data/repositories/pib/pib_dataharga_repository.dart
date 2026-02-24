import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_dataharga_response_model.dart';

class PibDataHargaRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibDataHargaResponseModel> fetchDataHarga(String car) async {
    final userId = await _storage.getUserId();
    final cleanedCar = car.replaceAll('-', '');

    final response = await _api.postRaw(
      'edeclaration/bc20/header/header',
      {
        "USER_ID": userId,
        "CAR": cleanedCar,
      },
    );

    if (response is Map<String, dynamic>) {
      return PibDataHargaResponseModel.fromJson(response);
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}