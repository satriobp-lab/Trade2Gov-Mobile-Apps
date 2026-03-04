import '../../repositories/pibk/pibk_pungutan_repository.dart';
import '../../models/pibk/pibk_pungutan_response_model.dart';

class PibkPungutanController {
  static final PibkPungutanRepository _repo =
  PibkPungutanRepository();

  static Future<PibkPungutanResponseModel?> getPungutan(String car) async {
    return await _repo.fetchPungutan(car);
  }
}