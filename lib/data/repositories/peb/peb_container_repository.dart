import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_container_response_model.dart';

class PebContainerRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PebContainerResponseModel>> fetchContainers({
    required String car,
  }) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/kontainer',
      {
        "USER_ID": userId,
        // "USER_ID": 175, // sementara force dulu
        "CAR": car,
      },
    );

    if (response == null) return [];

    if (response is List) {
      return response
          .map((e) => PebContainerResponseModel.fromJson(e))
          .toList();
    }

    throw Exception("Format response tidak sesuai");
  }
}