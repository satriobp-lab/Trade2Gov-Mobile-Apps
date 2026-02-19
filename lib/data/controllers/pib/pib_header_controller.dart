import '../../models/pib/pib_header_response_model.dart';
import '../../repositories/pib/pib_header_repository.dart';

class PibHeaderController {
  static final PibHeaderRepository _repository =
  PibHeaderRepository();

  static Future<PibHeaderResponseModel> getHeader(
      String car) async {
    return await _repository.fetchHeader(car);
  }
}
