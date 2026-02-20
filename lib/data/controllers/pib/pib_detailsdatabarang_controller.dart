import '../../repositories/pib/pib_detailsdatabarang_repository.dart';
import '../../models/pib/pib_detailsdatabarang_response_model.dart';

class PibDetailsDataBarangController {
  static final PibDetailsDataBarangRepository _repo =
  PibDetailsDataBarangRepository();

  static Future<PibDetailsDataBarangResponseModel> getDetails({
    required String car,
    required String serial,
  }) async {
    return await _repo.fetchDetails(
      car: car,
      serial: serial,
    );
  }
}