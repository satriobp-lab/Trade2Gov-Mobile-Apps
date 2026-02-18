import '../../repositories/pib/pib_historylist_repository.dart';
import '../../models/pib/pib_historylist_response_model.dart';
import '../../../core/app_cache.dart';

class PibHistoryListController {
  static final PibHistoryListRepository _repo =
  PibHistoryListRepository();

  static Future<List<PibHistoryListResponseModel>> getPibHistory() async {
    final data = await _repo.fetchPibHistory();

    // optional cache
    AppCache.pibHistoryList = data;

    return data;
  }
}
