import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pibk/pibk_historylist_response_model.dart';

class PibkHistoryListRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibkHistoryListResponseModel>> fetchPibkHistory() async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/pibk/header/browse',
      {
        "USER_ID": userId,
        // "USER_ID": 175,
      },
    );

    if (response == null) {
      return [];
    }

    if (response is List) {
      return response
          .map((e) => PibkHistoryListResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}