import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_dokumen_response_model.dart';

class PebDokumenRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();


  // KHUSUS IMPLEMENTASI SESUAI USER LOGIN
  Future<List<PebDokumenResponseModel>> fetchPebDokumen(String car) async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/dokumen',
      {
        "USER_ID": userId,
        "CAR": car,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PebDokumenResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }

  //Force USER ID 175
  // Future<List<PebDokumenResponseModel>> fetchPebDokumen(String car) async {
  //
  //   final response = await _api.postRaw(
  //     'edeclaration/bc30/header/dokumen',
  //     {
  //       "USER_ID": "175", // force hardcode
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
  //         .map((e) => PebDokumenResponseModel.fromJson(e))
  //         .toList();
  //   } else {
  //     throw Exception("Format response tidak sesuai");
  //   }
  // }
}