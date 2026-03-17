import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_listdatabarang_response_model.dart';

class PibkListDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibkListDataBarangResponseModel>> fetchListDataBarang(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/detail/barang_list',
      {
        "USER_ID": userId,
        // "USER_ID": 175,
        "CAR": car,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PibkListDataBarangResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}