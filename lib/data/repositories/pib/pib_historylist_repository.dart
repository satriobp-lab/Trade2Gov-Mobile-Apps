import '../../services/api_service.dart';
import '../../securestorage/secure_storage_service.dart';
import '../../models/pib/pib_historylist_response_model.dart';

class PibHistoryListRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<PibHistoryListResponseModel>> fetchPibHistory() async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/bc20/header/browse',
      {
        "USER_ID": userId,
      },
    );

    if (response is List) {
      return response
          .map((e) => PibHistoryListResponseModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Format response tidak sesuai");
    }
  }
}
