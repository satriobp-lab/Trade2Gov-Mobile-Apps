import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_dokumen_response_model.dart';

class PibkDokumenRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibkDokumenResponseModel>> fetchPibkDokumen(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/header/dokumen',
      {
        // "USER_ID": userId,
        "USER_ID": 175,
        "CAR": car,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PibkDokumenResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response PIBK Dokumen tidak sesuai");
    }
  }
}