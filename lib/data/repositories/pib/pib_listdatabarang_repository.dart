import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_listdatabarang_response_model.dart';

class PibListDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibListDataBarangResponseModel>> fetchListDataBarang(
      String car) async {

    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc20/detail/barang_list',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response is List) {
      return response
          .map((e) => PibListDataBarangResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}