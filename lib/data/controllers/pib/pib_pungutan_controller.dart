import '../../repositories/pib/pib_pungutan_repository.dart';
import '../../models/pib/pib_pungutan_response_model.dart';

class PibPungutanController {
  static final PibPungutanRepository _repo =
  PibPungutanRepository();

  static Future<PibPungutanResponseModel?> getPungutan(String car) async {
    return await _repo.fetchPungutan(car);
  }
}