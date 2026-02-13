import '../repositories/edec_repository.dart';
import '../models/edec_response_model.dart';
import '../../core/app_cache.dart';

class EdecController {
  static final EdecRepository _repo = EdecRepository();

  static Future<EdecResponseModel> getDashboard() async {
    final data = await _repo.fetchDashboard();

    AppCache.edecDashboard = data; // kita cache

    return data;
  }
}
