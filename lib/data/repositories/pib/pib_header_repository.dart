import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_header_response_model.dart';

class PibHeaderRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<PibHeaderResponseModel> fetchHeader(String car) async {
    final userId = await _storage.getUserId();

    final cleanedCar = car.replaceAll('-', '');

    print("CAR HEADER API: $cleanedCar");

    final response = await _api.postRaw(
      'edeclaration/bc20/header/header',
      {
        "USER_ID": userId,
        "CAR": cleanedCar,
      },
    );

    print("RESPONSE HEADER: $response");

    if (response is Map<String, dynamic>) {
      return PibHeaderResponseModel.fromJson(response);
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}
