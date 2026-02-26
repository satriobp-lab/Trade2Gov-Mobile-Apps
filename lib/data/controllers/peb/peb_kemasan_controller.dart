import '../../repositories/peb/peb_kemasan_repository.dart';
import '../../models/peb/peb_kemasan_response_model.dart';

class PebKemasanController {
  static final PebKemasanRepository _repo =
  PebKemasanRepository();

  static Future<List<PebKemasanResponseModel>> getKemasan({
    required String car,
  }) async {
    return await _repo.fetchKemasan(car: car);
  }
}