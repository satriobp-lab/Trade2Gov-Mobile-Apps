import '../../models/peb/peb_header_response_model.dart';
import '../../repositories/peb/peb_header_repository.dart';

class PebHeaderController {
  static final PebHeaderRepository _repository =
  PebHeaderRepository();

  static Future<PebHeaderResponseModel?> getPebHeader(
      String car) async {
    return await _repository.fetchPebHeader(car);
  }
}