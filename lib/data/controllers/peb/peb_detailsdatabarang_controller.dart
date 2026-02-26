import '../../repositories/peb/peb_detailsdatabarang_repository.dart';
import '../../models/peb/peb_detailsdatabarang_response_model.dart';

class PebDetailsDataBarangController {
  static final PebDetailsDataBarangRepository _repo =
  PebDetailsDataBarangRepository();

  static Future<PebDetailsDataBarangResponseModel?> getDetails({
    required String car,
    required String seriBrg,
  }) async {
    return await _repo.fetchDetails(
      car: car,
      seriBrg: seriBrg,
    );
  }
}