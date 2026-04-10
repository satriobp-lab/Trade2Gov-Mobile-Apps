import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/peb/peb_historylist_response_model.dart';

class PebHistoryListRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  //khusus implement all data
  Future<List<PebHistoryListResponseModel>> fetchPebHistory() async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc30/header/browse',
      {
        "USER_ID": userId,
      },
    );

    if (response is List) {
      return response
          .map((e) => PebHistoryListResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }

  // hapus ini - karena ini force user 175
  // Future<List<PebHistoryListResponseModel>> fetchPebHistory() async {
  //
  //   final userId = 175; // 🔥 paksa 175
  //
  //   final response = await _api.postRaw(
  //     'edeclaration/bc30/header/browse',
  //     {
  //       "USER_ID": userId,
  //     },
  //   );
  //
  //   if (response is List) {
  //     return response
  //         .map((e) => PebHistoryListResponseModel.fromJson(e))
  //         .toList();
  //   } else {
  //     throw Exception("Format response tidak sesuai");
  //   }
  // }
}