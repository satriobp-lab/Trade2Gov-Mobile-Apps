import '../../repositories/pib/pib_kemasan_repository.dart';
import '../../models/pib/pib_kemasan_response_model.dart';

class PibKemasanController {
  static final PibKemasanRepository _repo = PibKemasanRepository();

  static Future<List<PibKemasanResponseModel>> getKemasan(String car) async {
    return await _repo.fetchKemasan(car);
  }
}