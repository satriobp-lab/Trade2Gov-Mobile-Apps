import '../../repositories/pibk/pibk_header_repository.dart';
import '../../models/pibk/pibk_header_response_model.dart';

class PibkHeaderController {
  static final PibkHeaderRepository _repo =
  PibkHeaderRepository();

  static Future<PibkHeaderResponseModel?> getHeader(String car) async {
    return await _repo.fetchPibkHeader(car);
  }
}