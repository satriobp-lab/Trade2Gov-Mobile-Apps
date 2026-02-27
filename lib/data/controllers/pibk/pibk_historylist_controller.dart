import '../../repositories/pibk/pibk_historylist_repository.dart';
import '../../models/pibk/pibk_historylist_response_model.dart';
import '../../../core/app_cache.dart';

class PibkHistoryListController {
  static final PibkHistoryListRepository _repo =
  PibkHistoryListRepository();

  static Future<List<PibkHistoryListResponseModel>> getPibkHistory() async {
    final data = await _repo.fetchPibkHistory();

    // Optional cache
    AppCache.pibkHistoryList = data;

    return data;
  }
}