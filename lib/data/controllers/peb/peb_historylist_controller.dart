import '../../repositories/peb/peb_historylist_repository.dart';
import '../../models/peb/peb_historylist_response_model.dart';
import '../../../core/app_cache.dart';

class PebHistoryListController {
  static final PebHistoryListRepository _repo =
  PebHistoryListRepository();

  static Future<List<PebHistoryListResponseModel>> getPebHistory() async {
    final data = await _repo.fetchPebHistory();

    // Optional cache
    AppCache.pebHistoryList = data;

    return data;
  }
}