import '../../services/api_service.dart';
import '../../models/peb/peb_listdatabarang_response_model.dart';
import '../../securestorage/secure_storage_service.dart';

class PebListDataBarangRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  //khusus implement all data
  Future<List<PebListDataBarangResponseModel>> fetchListDataBarang({
    required String car,
  }) async {

    final userId = await _storage.getUserId();

    if (userId == null) {
      throw Exception("User belum login");
    }

    final response = await _api.postRaw(
      'edeclaration/bc30/detail/barang_list',
      {
        // "USER_ID": 175,
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PebListDataBarangResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }

  // // hapus ini - karena ini force user 175
  // Future<List<PebListDataBarangResponseModel>> fetchListDataBarang({
  //   required String car,
  // }) async {
  //   final response = await _api.postRaw(
  //     'edeclaration/bc30/detail/barang_list',
  //     {
  //       "USER_ID": 175, // 🔥 sementara force 175 (samakan dengan history)
  //       "CAR": car,
  //     },
  //   );
  //
  //   if (response == null) {
  //     return [];
  //   }
  //
  //   if (response is List) {
  //     return response
  //         .map((e) => PebListDataBarangResponseModel.fromJson(e))
  //         .toList();
  //   } else {
  //     throw Exception("Format response tidak sesuai");
  //   }
  // }
}