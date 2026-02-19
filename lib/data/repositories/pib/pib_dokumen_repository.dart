import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_dokumen_response_model.dart';

class PibDokumenRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibDokumenResponseModel>> fetchDokumen(String car) async {
    final userId = await _storage.getUserId();

    print("CAR DIKIRIM KE API: $car");

    final response = await _api.postRaw(
      'edeclaration/bc20/header/dokumen',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    print("RESPONSE DOKUMEN: $response");

    if (response is List) {
      return response
          .map((e) => PibDokumenResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}
